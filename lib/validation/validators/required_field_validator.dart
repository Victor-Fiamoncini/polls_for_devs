import 'package:polls_for_devs/validation/protocols/field_validator.dart';

class RequiredFieldValidator implements FieldValidator {
  @override
  final String field;

  RequiredFieldValidator(this.field);

  @override
  String validate(String value) {
    return value?.isNotEmpty == true ? null : 'Campo obrigatório.';
  }
}
