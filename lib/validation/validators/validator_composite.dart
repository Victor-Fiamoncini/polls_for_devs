import 'package:meta/meta.dart';
import 'package:polls_for_devs/presentation/protocols/validation.dart';
import 'package:polls_for_devs/validation/protocols/field_validator.dart';

class ValidatorComposite implements Validation {
  final List<FieldValidator> validators;

  ValidatorComposite(this.validators);

  @override
  String validate({@required String field, @required String value}) {
    String error;

    final filteredValidators = validators.where(
      (validator) => validator.field == field,
    );

    for (final validator in filteredValidators) {
      error = validator.validate(value);

      if (error?.isNotEmpty == true) {
        return error;
      }
    }

    return error;
  }
}
