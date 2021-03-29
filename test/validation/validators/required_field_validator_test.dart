import 'package:test/test.dart';

abstract class FieldValidator {
  String get field;

  String validate(String value);
}

class RequiredFieldValidator implements FieldValidator {
  @override
  final String field;

  RequiredFieldValidator(this.field);

  @override
  String validate(String value) {
    return value.isEmpty ? 'Campo obrigatório.' : null;
  }
}

void main() {
  test('Should return null if value is not empty', () {
    final sut = RequiredFieldValidator('any_field');

    final error = sut.validate('any_value');

    expect(error, null);
  });

  test('Should return error if value is empty', () {
    final sut = RequiredFieldValidator('any_field');

    final error = sut.validate('');

    expect(error, 'Campo obrigatório.');
  });
}
