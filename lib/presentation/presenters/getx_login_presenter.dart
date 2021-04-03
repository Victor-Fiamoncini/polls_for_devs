import 'package:get/get.dart';
import 'package:meta/meta.dart';
import 'package:polls_for_devs/domain/helpers/domain_error.dart';
import 'package:polls_for_devs/domain/use_cases/authentication_use_case.dart';
import 'package:polls_for_devs/presentation/protocols/validation.dart';
import 'package:polls_for_devs/ui/pages/login/login_presenter.dart';

class GetxLoginPresenter extends GetxController implements LoginPresenter {
  final Validation validation;
  final AuthenticationUseCase authentication;

  String _email;
  String _password;

  final _emailError = RxString(null);
  final _passwordError = RxString(null);
  final _mainError = RxString(null);
  final _isFormValid = RxBool(false);
  final _isLoading = RxBool(false);

  GetxLoginPresenter({
    @required this.validation,
    @required this.authentication,
  });

  @override
  Stream<String> get emailErrorStream => _emailError.stream;

  @override
  Stream<String> get passwordErrorStream => _passwordError.stream;

  @override
  Stream<String> get mainErrorStream => _mainError.stream;

  @override
  Stream<bool> get isFormValidStream => _isFormValid.stream;

  @override
  Stream<bool> get isLoadingStream => _isLoading.stream;

  @override
  void validateEmail(String email) {
    _email = email;
    _emailError.value = validation.validate(field: 'email', value: email);

    _validateForm();
  }

  @override
  void validatePassword(String password) {
    _password = password;
    _passwordError.value = validation.validate(
      field: 'password',
      value: password,
    );

    _validateForm();
  }

  void _validateForm() {
    _isFormValid.value = _emailError.value == null &&
        _passwordError.value == null &&
        _email != null &&
        _password != null;
  }

  @override
  Future<void> auth() async {
    _isLoading.value = true;

    try {
      await authentication.auth(
        AuthenticationUseCaseParams(email: _email, secret: _password),
      );
    } on DomainError catch (err) {
      _mainError.value = err.description;
    }

    _isLoading.value = false;
  }

  @override
  void dispose() {}
}
