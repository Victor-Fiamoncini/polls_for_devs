import 'package:polls_for_devs/presentation/protocols/validation.dart';
import 'package:polls_for_devs/validation/validators/email_validator.dart';
import 'package:polls_for_devs/validation/validators/required_field_validator.dart';
import 'package:polls_for_devs/validation/validators/validator_composite.dart';

Validation makeLoginValidator() {
  return ValidatorComposite([
    RequiredFieldValidator('email'),
    EmailValidator('email'),
    RequiredFieldValidator('password'),
  ]);
}
