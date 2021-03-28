import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:polls_for_devs/domain/entities/account_entity.dart';

abstract class AuthenticationUseCase {
  Future<AccountEntity> auth(AuthenticationUseCaseParams params);
}

class AuthenticationUseCaseParams extends Equatable {
  final String email;
  final String secret;

  const AuthenticationUseCaseParams({
    @required this.email,
    @required this.secret,
  });

  @override
  List get props => [email, secret];
}
