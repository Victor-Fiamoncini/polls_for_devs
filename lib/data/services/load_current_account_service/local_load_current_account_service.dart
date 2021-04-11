import 'package:meta/meta.dart';
import 'package:polls_for_devs/domain/entities/account_entity.dart';
import 'package:polls_for_devs/domain/use_cases/load_current_account_use_case.dart';

class LocalLoadCurrentAccountService implements LoadCurrentAccountUseCase {
  LocalLoadCurrentAccountService();

  @override
  Future<AccountEntity> load() async {
    throw UnimplementedError();
  }
}
