import 'package:mockito/mockito.dart';
import 'package:polls_for_devs/validation/protocols/field_validator.dart';
import 'package:polls_for_devs/validation/validators/validator_composite.dart';
import 'package:test/test.dart';

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
