import 'package:faker/faker.dart';
import 'package:meta/meta.dart';
import 'package:mockito/mockito.dart';
import 'package:polls_for_devs/domain/entities/account_entity.dart';
import 'package:polls_for_devs/domain/helpers/domain_error.dart';
import 'package:polls_for_devs/domain/use_cases/save_current_account_use_case.dart';
import 'package:test/test.dart';

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

abstract class SaveSecureCacheStorage {
  Future<void> saveSecure({@required String key, @required String value});
}

class SaveSecureCacheStorageSpy extends Mock implements SaveSecureCacheStorage {
}

void main() {
  SaveSecureCacheStorageSpy saveSecureCacheStorage;
  LocalSaveCurrentAccountService sut;
  AccountEntity account;

  void mockError() {
    when(
      saveSecureCacheStorage.saveSecure(
        key: anyNamed('key'),
        value: anyNamed('value'),
      ),
    ).thenThrow(Exception());
  }

  setUp(() {
    saveSecureCacheStorage = SaveSecureCacheStorageSpy();
    sut = LocalSaveCurrentAccountService(
      saveSecureCacheStorage: saveSecureCacheStorage,
    );
    account = AccountEntity(faker.guid.guid());
  });

  test('Should call SaveSecureCacheStorage with correct values', () async {
    await sut.save(account);

    verify(
      saveSecureCacheStorage.saveSecure(key: 'token', value: account.token),
    );
  });

  test('Should throw UnexpectedError if SaveSecureCacheStorage throw', () {
    mockError();

    final future = sut.save(account);

    expect(future, throwsA(DomainError.unexpected));
  });
}
