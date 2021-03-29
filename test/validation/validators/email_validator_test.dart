import 'package:polls_for_devs/validation/protocols/field_validator.dart';
import 'package:test/test.dart';

class EmailValidator implements FieldValidator {
  @override
  final String field;

  EmailValidator(this.field);

  @override
  String validate(String value) {
    return null;
  }
}

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
}
