import 'package:faker/faker.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:mockito/mockito.dart';
import 'package:polls_for_devs/infra/cache/local_storage_adapter.dart';
import 'package:test/test.dart';

class FlutterSecureStorageSpy extends Mock implements FlutterSecureStorage {}

void main() {
  LocalStorageAdapter sut;
  FlutterSecureStorageSpy secureStorage;
  String key;
  String value;

  setUp(() {
    secureStorage = FlutterSecureStorageSpy();
    sut = LocalStorageAdapter(secureStorage: secureStorage);
    key = faker.lorem.word();
    value = faker.guid.guid();
  });

  group('Save Secure', () {
    void mockError() {
      when(
        secureStorage.write(
          key: anyNamed('key'),
          value: anyNamed('value'),
        ),
      ).thenThrow(Exception());
    }

    test('Should call save secure with correct values', () async {
      await sut.saveSecure(key: key, value: value);

      verify(secureStorage.write(key: key, value: value)).called(1);
    });

    test('Should throw if save secure throws', () {
      mockError();

      final future = sut.saveSecure(key: key, value: value);

      expect(future, throwsA(const TypeMatcher<Exception>()));
    });
  });

  group('Fetch Secure', () {
    PostExpectation mockFetchSecureCall() {
      return when(secureStorage.read(key: anyNamed('key')));
    }

    void mockSuccess() => mockFetchSecureCall().thenAnswer((_) async => value);

    void mockError() => mockFetchSecureCall().thenThrow(Exception());

    setUp(() {
      mockSuccess();
    });

    test('Should call fetch secure with correct value', () async {
      await sut.fetchSecure(key);

      verify(secureStorage.read(key: key)).called(1);
    });

    test('Should return correct value on success', () async {
      final fetchedValue = await sut.fetchSecure(key);

      expect(fetchedValue, value);
    });

    test('Should throw if fetch secure throws', () {
      mockError();

      final future = sut.fetchSecure(key);

      expect(future, throwsA(const TypeMatcher<Exception>()));
    });
  });
}
