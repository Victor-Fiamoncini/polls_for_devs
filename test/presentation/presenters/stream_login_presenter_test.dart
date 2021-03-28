import 'package:faker/faker.dart';
import 'package:mockito/mockito.dart';
import 'package:polls_for_devs/presentation/presenters/stream_login_presenter.dart';
import 'package:polls_for_devs/presentation/protocols/validation.dart';
import 'package:test/test.dart';

class ValidationSpy extends Mock implements Validation {}

void main() {
  ValidationSpy validation;
  StreamLoginPresenter sut;
  String email;

  PostExpectation mockValidationCall(String field) {
    return when(
      validation.validate(
        field: field ?? anyNamed('field'),
        value: anyNamed('value'),
      ),
    );
  }

  void mockValidation({String field, String value}) {
    mockValidationCall(field).thenReturn(value);
  }

  setUp(() {
    validation = ValidationSpy();
    sut = StreamLoginPresenter(validation: validation);
    email = faker.internet.email();
    mockValidation();
  });

  test('Should call Validation with correct email', () {
    sut.validateEmail(email);

    verify(validation.validate(field: 'email', value: email)).called(1);
  });

  test('Should emit one email error if validation fails', () {
    mockValidation(value: 'error');

    sut.emailErrorStream.listen(
      expectAsync1((error) => expect(error, 'error')),
    );

    sut.validateEmail(email);
    sut.validateEmail(email);
  });
}
