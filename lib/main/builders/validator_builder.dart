import 'package:polls_for_devs/validation/protocols/field_validator.dart';
import 'package:polls_for_devs/validation/validators/email_validator.dart';
import 'package:polls_for_devs/validation/validators/required_field_validator.dart';

class ValidatorBuilder {
  String fieldName;
  List<FieldValidator> validators = [];

  static ValidatorBuilder _instance;

  ValidatorBuilder._();

  static ValidatorBuilder field(String fieldName) {
    _instance = ValidatorBuilder._();
    _instance.fieldName = fieldName;

    return _instance;
  }

  ValidatorBuilder required() {
    validators.add(RequiredFieldValidator(fieldName));

    return this;
  }

  ValidatorBuilder email() {
    validators.add(EmailValidator(fieldName));

    return this;
  }

  List<FieldValidator> build() => validators;
}
