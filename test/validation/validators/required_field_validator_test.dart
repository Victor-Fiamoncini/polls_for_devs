import 'package:polls_for_devs/validation/validators/required_field_validator.dart';
import 'package:test/test.dart';

void main() {
  RequiredFieldValidator sut;

  setUp(() {
    sut = RequiredFieldValidator('any_field');
  });

  test('Should return null if value is not empty', () {
    final error = sut.validate('any_value');

    expect(error, null);
  });

  test('Should return error if value is empty', () {
    final error = sut.validate('');

    expect(error, 'Campo obrigatório.');
  });

  test('Should return error if value is null', () {
    final error = sut.validate(null);

    expect(error, 'Campo obrigatório.');
  });
}
