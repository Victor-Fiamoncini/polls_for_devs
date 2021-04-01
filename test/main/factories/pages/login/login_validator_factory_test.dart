import 'package:polls_for_devs/main/factories/pages/login/login_validator_factory.dart';
import 'package:polls_for_devs/validation/validators/email_validator.dart';
import 'package:polls_for_devs/validation/validators/required_field_validator.dart';
import 'package:test/test.dart';

void main() {
  test('Should return the correct validators', () {
    final validations = makeLoginValidators();

    expect(validations, [
      const RequiredFieldValidator('email'),
      const EmailValidator('email'),
      const RequiredFieldValidator('password'),
    ]);
  });
}
