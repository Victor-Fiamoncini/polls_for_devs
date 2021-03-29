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
    return value?.isNotEmpty == true ? null : 'Campo obrigatório.';
  }
}

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
