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
    return null;
  }
}

class FieldValidatorSpy extends Mock implements FieldValidator {}

void main() {
  ValidatorComposite sut;

  setUp(() {
    sut = ValidatorComposite([]);
  });

  test('Should return null if all validators returns null or empty', () {
    final validator01 = FieldValidatorSpy();
    when(validator01.field).thenReturn('any_field');
    when(validator01.validate(any)).thenReturn(null);

    final validator02 = FieldValidatorSpy();
    when(validator02.field).thenReturn('any_field');
    when(validator02.validate(any)).thenReturn('');

    sut = ValidatorComposite([validator01, validator02]);

    final error = sut.validate(field: 'any_field', value: 'any_value');

    expect(error, null);
  });
}
