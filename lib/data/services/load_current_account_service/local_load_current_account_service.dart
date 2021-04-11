import 'package:meta/meta.dart';
import 'package:polls_for_devs/data/cache/fetch_secure_cache_storage.dart';
import 'package:polls_for_devs/domain/entities/account_entity.dart';
import 'package:polls_for_devs/domain/use_cases/load_current_account_use_case.dart';

class LocalLoadCurrentAccountService implements LoadCurrentAccountUseCase {
  final FetchSecureCacheStorage fetchSecureCacheStorage;

  LocalLoadCurrentAccountService({@required this.fetchSecureCacheStorage});

  @override
  Future<AccountEntity> load() async {
    final token = await fetchSecureCacheStorage.fetchSecure('token');

    return AccountEntity(token);
  }
}
