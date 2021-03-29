import 'package:faker/faker.dart';
import 'package:polls_for_devs/validation/validators/email_validator.dart';
import 'package:test/test.dart';

void main() {
  EmailValidator sut;

  setUp(() {
    sut = EmailValidator('any_email');
  });

  test('Should return null if email is empty', () {
    final error = sut.validate('');

    expect(error, null);
  });

  test('Should return null if email is null', () {
    final error = sut.validate(null);

    expect(error, null);
  });

  test('Should return null if email is valid', () {
    final error = sut.validate(faker.internet.email());

    expect(error, null);
  });

  test('Should return error if email is invalid', () {
    final error = sut.validate('invalid_email');

    expect(error, 'Email inválido.');
  });
}
