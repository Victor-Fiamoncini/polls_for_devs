import 'package:polls_for_devs/domain/entities/account_entity.dart';

abstract class SaveCurrentAccountUseCase {
  Future<void> save(AccountEntity account);
}
