import 'package:meta/meta.dart';
import 'package:polls_for_devs/features/login/domain/entities/account_entity.dart';

abstract class AuthenticationUseCase {
  Future<AccountEntity> auth({
    @required String email,
    @required String password,
  });
}
