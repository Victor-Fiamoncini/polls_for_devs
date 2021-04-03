import 'package:meta/meta.dart';
import 'package:polls_for_devs/data/cache/save_secure_cache_storage.dart';
import 'package:polls_for_devs/domain/entities/account_entity.dart';
import 'package:polls_for_devs/domain/helpers/domain_error.dart';
import 'package:polls_for_devs/domain/use_cases/save_current_account_use_case.dart';

class LocalSaveCurrentAccountService implements SaveCurrentAccountUseCase {
  final SaveSecureCacheStorage saveSecureCacheStorage;

  LocalSaveCurrentAccountService({@required this.saveSecureCacheStorage});

  @override
  Future<void> save(AccountEntity account) async {
    try {
      await saveSecureCacheStorage.saveSecure(
        key: 'token',
        value: account.token,
      );
    } catch (err) {
      throw DomainError.unexpected;
    }
  }
}
