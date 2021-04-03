import 'package:faker/faker.dart';
import 'package:meta/meta.dart';
import 'package:mockito/mockito.dart';
import 'package:polls_for_devs/domain/entities/account_entity.dart';
import 'package:polls_for_devs/domain/use_cases/save_current_account_use_case.dart';
import 'package:test/test.dart';

class LocalSaveCurrentAccountService implements SaveCurrentAccountUseCase {
  final SaveSecureCacheStorage saveSecureCacheStorage;

  LocalSaveCurrentAccountService({@required this.saveSecureCacheStorage});

  @override
  Future<void> save(AccountEntity account) async {
    await saveSecureCacheStorage.saveSecure(key: 'token', value: account.token);
  }
}

abstract class SaveSecureCacheStorage {
  Future<void> saveSecure({@required String key, @required String value});
}

class SaveSecureCacheStorageSpy extends Mock implements SaveSecureCacheStorage {
}

void main() {
  test('Should call SaveCacheStorage with correct values', () async {
    final saveSecureCacheStorage = SaveSecureCacheStorageSpy();
    final sut = LocalSaveCurrentAccountService(
      saveSecureCacheStorage: saveSecureCacheStorage,
    );
    final account = AccountEntity(faker.guid.guid());

    sut.save(account);

    verify(
      saveSecureCacheStorage.saveSecure(key: 'token', value: account.token),
    );
  });
}
