import 'package:faker/faker.dart';
import 'package:mockito/mockito.dart';
import 'package:polls_for_devs/data/cache/fetch_secure_cache_storage.dart';
import 'package:polls_for_devs/data/services/load_current_account_service/local_load_current_account_service.dart';
import 'package:test/test.dart';

class FetchSecureCacheStorageSpy extends Mock
    implements FetchSecureCacheStorage {}

void main() {
  LocalLoadCurrentAccountService sut;
  FetchSecureCacheStorageSpy fetchSecureCacheStorage;

  setUp(() {
    fetchSecureCacheStorage = FetchSecureCacheStorageSpy();
    sut = LocalLoadCurrentAccountService(
      fetchSecureCacheStorage: fetchSecureCacheStorage,
    );
  });

  test('Should call FetchSecureCacheStorage with correct value', () async {
    await sut.load();

    verify(fetchSecureCacheStorage.fetchSecure('token')).called(1);
  });
}
