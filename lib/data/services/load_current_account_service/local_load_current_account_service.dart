import 'package:meta/meta.dart';
import 'package:polls_for_devs/data/cache/fetch_secure_cache_storage.dart';

class LocalLoadCurrentAccountService {
  final FetchSecureCacheStorage fetchSecureCacheStorage;

  LocalLoadCurrentAccountService({@required this.fetchSecureCacheStorage});

  Future<void> load() async {
    await fetchSecureCacheStorage.fetchSecure('token');
  }
}
