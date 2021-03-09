import 'package:meta/meta.dart';
import 'package:polls_for_devs/domain/use_cases/authentication_use_case.dart';

class RemoteAuthenticationMapper {
  final String email;
  final String password;

  RemoteAuthenticationMapper({
    @required this.email,
    @required this.password,
  });

  factory RemoteAuthenticationMapper.fromDomain(
    AuthenticationUseCaseParams authenticationUseCaseParams,
  ) {
    return RemoteAuthenticationMapper(
      email: authenticationUseCaseParams.email,
      password: authenticationUseCaseParams.secret,
    );
  }

  Map toJson() {
    return {
      'email': email,
      'password': password,
    };
  }
}
