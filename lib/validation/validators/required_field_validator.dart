import 'package:equatable/equatable.dart';
import 'package:polls_for_devs/validation/protocols/field_validator.dart';

class RequiredFieldValidator extends Equatable implements FieldValidator {
  @override
  final String field;

  const RequiredFieldValidator(this.field);

  @override
  List get props => [field];

  @override
  String validate(String value) {
    return value?.isNotEmpty == true ? null : 'Campo obrigatório.';
  }
}
