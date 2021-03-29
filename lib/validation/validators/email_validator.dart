import 'package:polls_for_devs/validation/protocols/field_validator.dart';

class EmailValidator implements FieldValidator {
  @override
  final String field;

  EmailValidator(this.field);

  @override
  String validate(String value) {
    final emailRegex = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
    );

    final isValid = value?.isNotEmpty != true || emailRegex.hasMatch(value);

    return isValid ? null : 'Email inválido.';
  }
}
