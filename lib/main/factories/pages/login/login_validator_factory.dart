import 'package:polls_for_devs/presentation/protocols/validation.dart';
import 'package:polls_for_devs/validation/protocols/field_validator.dart';
import 'package:polls_for_devs/validation/validators/email_validator.dart';
import 'package:polls_for_devs/validation/validators/required_field_validator.dart';
import 'package:polls_for_devs/validation/validators/validator_composite.dart';

Validation makeLoginValidation() {
  return ValidatorComposite(makeLoginValidators());
}

List<FieldValidator> makeLoginValidators() {
  return [
    RequiredFieldValidator('email'),
    EmailValidator('email'),
    RequiredFieldValidator('password'),
  ];
}
