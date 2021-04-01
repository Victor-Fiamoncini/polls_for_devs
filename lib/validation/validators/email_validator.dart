import 'package:equatable/equatable.dart';
import 'package:polls_for_devs/validation/protocols/field_validator.dart';

class EmailValidator extends Equatable implements FieldValidator {
  @override
  final String field;

  const EmailValidator(this.field);

  @override
  List get props => [field];

  @override
  String validate(String value) {
    final emailRegex = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
    );

    final isValid = value?.isNotEmpty != true || emailRegex.hasMatch(value);

    return isValid ? null : 'Email inválido.';
  }
}
