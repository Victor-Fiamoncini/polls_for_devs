import 'package:faker/faker.dart';
import 'package:mockito/mockito.dart';
import 'package:polls_for_devs/domain/entities/account_entity.dart';
import 'package:polls_for_devs/domain/helpers/domain_error.dart';
import 'package:polls_for_devs/domain/use_cases/authentication_use_case.dart';
import 'package:polls_for_devs/presentation/presenters/stream_login_presenter.dart';
import 'package:polls_for_devs/presentation/protocols/validation.dart';
import 'package:test/test.dart';

class ValidationSpy extends Mock implements Validation {}

class AuthenticationSpy extends Mock implements AuthenticationUseCase {}

void main() {
  ValidationSpy validation;
  AuthenticationSpy authentication;
  StreamLoginPresenter sut;
  String email;
  String password;

  PostExpectation mockValidationCall(String field) {
    return when(
      validation.validate(
        field: field ?? anyNamed('field'),
        value: anyNamed('value'),
      ),
    );
  }

  void mockValidation({String field, String value}) {
    mockValidationCall(field).thenReturn(value);
  }

  PostExpectation mockAuthenticationCall() => when(authentication.auth(any));

  void mockAuthentication() {
    mockAuthenticationCall().thenAnswer(
      (_) async => AccountEntity(faker.guid.guid()),
    );
  }

  void mockAuthenticationError(DomainError error) {
    mockAuthenticationCall().thenThrow(error);
  }

  setUp(() {
    validation = ValidationSpy();
    authentication = AuthenticationSpy();
    sut = StreamLoginPresenter(
      validation: validation,
      authentication: authentication,
    );
    email = faker.internet.email();
    password = faker.internet.password();
    mockValidation();
    mockAuthentication();
  });

  test('Should call Validation with correct email', () {
    sut.validateEmail(email);

    verify(validation.validate(field: 'email', value: email)).called(1);
  });

  test('Should emit an email error if validation fails', () {
    mockValidation(value: 'error');

    sut.emailErrorStream.listen(
      expectAsync1((error) => expect(error, 'error')),
    );

    sut.isFormValidStream.listen(
      expectAsync1((isValid) => expect(isValid, false)),
    );

    sut.validateEmail(email);
    sut.validateEmail(email);
  });

  test('Should emit null if email validation succeeds', () {
    sut.emailErrorStream.listen(expectAsync1((error) => expect(error, null)));

    sut.isFormValidStream.listen(
      expectAsync1((isValid) => expect(isValid, false)),
    );

    sut.validateEmail(email);
    sut.validateEmail(email);
  });

  test('Should call Validation with correct password', () {
    sut.validatePassword(password);

    verify(validation.validate(field: 'password', value: password)).called(1);
  });

  test('Should emit a password error if validation fails', () {
    mockValidation(value: 'error');

    sut.passwordErrorStream.listen(
      expectAsync1((error) => expect(error, 'error')),
    );

    sut.isFormValidStream.listen(
      expectAsync1((isValid) => expect(isValid, false)),
    );

    sut.validatePassword(password);
    sut.validatePassword(password);
  });

  test('Should emit null if password validation succeeds', () {
    sut.passwordErrorStream.listen(
      expectAsync1((error) => expect(error, null)),
    );

    sut.isFormValidStream.listen(
      expectAsync1((isValid) => expect(isValid, false)),
    );

    sut.validatePassword(password);
    sut.validatePassword(password);
  });

  test('Should emit form invalid error if any field validation fails', () {
    mockValidation(field: 'email', value: 'error');

    sut.emailErrorStream.listen(
      expectAsync1((error) => expect(error, 'error')),
    );

    sut.passwordErrorStream.listen(
      expectAsync1((error) => expect(error, null)),
    );

    sut.isFormValidStream.listen(
      expectAsync1((isValid) => expect(isValid, false)),
    );

    sut.validateEmail(email);
    sut.validatePassword(password);
  });

  test('Should emit form success if fields are valid', () async {
    sut.emailErrorStream.listen(
      expectAsync1((error) => expect(error, null)),
    );

    sut.passwordErrorStream.listen(
      expectAsync1((error) => expect(error, null)),
    );

    expectLater(sut.isFormValidStream, emitsInOrder([false, true]));

    sut.validateEmail(email);
    await Future.delayed(Duration.zero);
    sut.validatePassword(password);
  });

  test('Should call Authentication with correct values', () async {
    sut.validateEmail(email);
    sut.validatePassword(password);

    await sut.auth();

    verify(
      authentication.auth(
        AuthenticationUseCaseParams(
          email: email,
          secret: password,
        ),
      ),
    ).called(1);
  });

  test(
    'Should emit correct loading events on Authentication success',
    () async {
      sut.validateEmail(email);
      sut.validatePassword(password);

      expectLater(sut.isLoadingStream, emitsInOrder([true, false]));

      await sut.auth();
    },
  );

  test(
    'Should emit correct loading events on InvalidCredentialsError',
    () async {
      mockAuthenticationError(DomainError.invalidCredentials);

      sut.validateEmail(email);
      sut.validatePassword(password);

      expectLater(sut.isLoadingStream, emits(false));
      sut.mainErrorStream.listen(
        expectAsync1((error) => expect(error, 'Credenciais inválidas.')),
      );

      await sut.auth();
    },
  );

  test(
    'Should emit correct loading events on UnexpectedError',
    () async {
      mockAuthenticationError(DomainError.unexpected);

      sut.validateEmail(email);
      sut.validatePassword(password);

      expectLater(sut.isLoadingStream, emits(false));
      sut.mainErrorStream.listen(
        expectAsync1(
          (error) => expect(
            error,
            'Algo errado aconteceu. Tente novamente em breve.',
          ),
        ),
      );

      await sut.auth();
    },
  );
}
