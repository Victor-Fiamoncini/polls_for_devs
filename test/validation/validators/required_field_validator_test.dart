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
    return null;
  }
}

void main() {
  test('Should return null if valid is not empty', () {
    final sut = RequiredFieldValidator('any_field');

    final error = sut.validate('any_value');

    expect(error, null);
  });
}
