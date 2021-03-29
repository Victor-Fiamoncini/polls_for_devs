import 'package:meta/meta.dart';
import 'package:mockito/mockito.dart';
import 'package:polls_for_devs/presentation/protocols/validation.dart';
import 'package:polls_for_devs/validation/protocols/field_validator.dart';
import 'package:test/test.dart';

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

class FieldValidatorSpy extends Mock implements FieldValidator {}

void main() {
  ValidatorComposite sut;
  FieldValidatorSpy validator01;
  FieldValidatorSpy validator02;
  FieldValidatorSpy validator03;

  void mockValidation01(String error) {
    when(validator01.validate(any)).thenReturn(error);
  }

  void mockValidation02(String error) {
    when(validator02.validate(any)).thenReturn(error);
  }

  void mockValidation03(String error) {
    when(validator03.validate(any)).thenReturn(error);
  }

  setUp(() {
    validator01 = FieldValidatorSpy();
    when(validator01.field).thenReturn('other_field');
    mockValidation01(null);

    validator02 = FieldValidatorSpy();
    when(validator02.field).thenReturn('any_field');
    mockValidation02(null);

    validator03 = FieldValidatorSpy();
    when(validator03.field).thenReturn('any_field');
    mockValidation03(null);

    sut = ValidatorComposite([validator01, validator02, validator03]);
  });

  test('Should return null if all validators returns null or empty', () {
    mockValidation02('');

    final error = sut.validate(field: 'any_field', value: 'any_value');

    expect(error, null);
  });

  test('Should return the first error found', () {
    mockValidation01('error_01');
    mockValidation02('error_02');
    mockValidation03('error_03');

    final error = sut.validate(field: 'any_field', value: 'any_value');

    expect(error, 'error_02');
  });
}
