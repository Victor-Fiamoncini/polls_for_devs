import 'package:meta/meta.dart';
import 'package:polls_for_devs/domain/entities/account_entity.dart';

abstract class AuthenticationUseCase {
  Future<AccountEntity> auth(AuthenticationUseCaseParams params);
}

class AuthenticationUseCaseParams {
  final String email;
  final String secret;

  AuthenticationUseCaseParams({@required this.email, @required this.secret});

  Map toJson() => {'email': email, 'password': secret};
}
