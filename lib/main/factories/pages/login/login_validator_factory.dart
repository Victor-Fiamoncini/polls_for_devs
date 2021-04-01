import 'package:polls_for_devs/main/builders/validator_builder.dart';
import 'package:polls_for_devs/presentation/protocols/validation.dart';
import 'package:polls_for_devs/validation/protocols/field_validator.dart';
import 'package:polls_for_devs/validation/validators/validator_composite.dart';

Validation makeLoginValidation() {
  return ValidatorComposite(makeLoginValidators());
}

List<FieldValidator> makeLoginValidators() {
  return [
    ...ValidatorBuilder.field('email').required().email().build(),
    ...ValidatorBuilder.field('password').required().build(),
  ];
}
