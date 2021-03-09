import 'package:faker/faker.dart';
import 'package:mockito/mockito.dart';
import 'package:polls_for_devs/data/http/http_client.dart';
import 'package:polls_for_devs/data/http/http_error.dart';
import 'package:polls_for_devs/data/services/remote_authentication_service.dart';
import 'package:polls_for_devs/domain/helpers/domain_error.dart';
import 'package:polls_for_devs/domain/use_cases/authentication_use_case.dart';
import 'package:test/test.dart';

class HttpClientSpy extends Mock implements HttpClient {}

void main() {
  RemoteAuthenticationService sut;
  HttpClient httpClient;
  String url;
  AuthenticationUseCaseParams params;

  Map mockValidData() {
    return {
      'accessToken': faker.guid.guid(),
      'name': faker.person.name(),
    };
  }

  PostExpectation mockRemoteAuthRequest() {
    return when(
      httpClient.request(
        url: anyNamed('url'),
        method: anyNamed('method'),
        body: anyNamed('body'),
      ),
    );
  }

  void mockHttpData(Map data) {
    mockRemoteAuthRequest().thenAnswer((_) async => data);
  }

  void mockHttpError(HttpError error) {
    mockRemoteAuthRequest().thenThrow(error);
  }

  setUp(() {
    httpClient = HttpClientSpy();
    url = faker.internet.httpUrl();
    sut = RemoteAuthenticationService(httpClient: httpClient, url: url);
    params = AuthenticationUseCaseParams(
      email: faker.internet.email(),
      secret: faker.internet.password(),
    );
    mockHttpData(mockValidData());
  });

  test('Should call HttpClient with correct values', () async {
    await sut.auth(params);

    verify(httpClient.request(
      url: url,
      method: 'post',
      body: {
        'email': params.email,
        'password': params.secret,
      },
    ));
  });

  test('Should throw UnexpectedError if HttpClient returns 400', () async {
    mockHttpError(HttpError.badRequest);

    final future = sut.auth(params);

    expect(future, throwsA(DomainError.unexpected));
  });

  test('Should throw UnexpectedError if HttpClient returns 404', () async {
    mockHttpError(HttpError.notFound);

    final future = sut.auth(params);

    expect(future, throwsA(DomainError.unexpected));
  });

  test('Should throw UnexpectedError if HttpClient returns 500', () async {
    mockHttpError(HttpError.serverError);

    final future = sut.auth(params);

    expect(future, throwsA(DomainError.unexpected));
  });

  test(
    'Should throw InvalidCredentialsError if HttpClient returns 401',
    () async {
      mockHttpError(HttpError.unauthorized);

      final future = sut.auth(params);

      expect(future, throwsA(DomainError.invalidCredentials));
    },
  );

  test('Should return an Account if HttpClient returns 200', () async {
    final validData = mockValidData();
    mockHttpData(validData);

    final account = await sut.auth(params);

    expect(account.token, validData['accessToken']);
  });

  test(
    'Should throw an UnexpectedError if HttpClient returns 200 with invalid data',
    () async {
      mockHttpData({'invalid_key': 'invalid_value'});

      final future = sut.auth(params);

      expect(future, throwsA(DomainError.unexpected));
    },
  );
}
