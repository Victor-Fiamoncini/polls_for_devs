import 'package:meta/meta.dart';
import 'package:polls_for_devs/data/http/http_client.dart';
import 'package:polls_for_devs/data/http/http_error.dart';
import 'package:polls_for_devs/domain/helpers/domain_error.dart';
import 'package:polls_for_devs/domain/use_cases/authentication_use_case.dart';

class RemoteAuthenticationService {
  final HttpClient httpClient;
  final String url;

  RemoteAuthenticationService({@required this.httpClient, @required this.url});

  Future<void> auth(AuthenticationUseCaseParams params) async {
    final body = RemoteAuthenticationServiceParams.fromDomain(params).toJson();

    try {
      await httpClient.request(
        url: url,
        method: 'post',
        body: body,
      );
    } on HttpError {
      throw DomainError.unexpected;
    }
  }
}

class RemoteAuthenticationServiceParams {
  final String email;
  final String password;

  RemoteAuthenticationServiceParams({
    @required this.email,
    @required this.password,
  });

  factory RemoteAuthenticationServiceParams.fromDomain(
    AuthenticationUseCaseParams authenticationUseCaseParams,
  ) {
    return RemoteAuthenticationServiceParams(
      email: authenticationUseCaseParams.email,
      password: authenticationUseCaseParams.secret,
    );
  }

  Map toJson() => {'email': email, 'password': password};
}
