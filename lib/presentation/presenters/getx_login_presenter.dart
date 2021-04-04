import 'package:get/get.dart';
import 'package:meta/meta.dart';
import 'package:polls_for_devs/domain/helpers/domain_error.dart';
import 'package:polls_for_devs/domain/use_cases/authentication_use_case.dart';
import 'package:polls_for_devs/domain/use_cases/save_current_account_use_case.dart';
import 'package:polls_for_devs/presentation/protocols/validation.dart';
import 'package:polls_for_devs/ui/pages/login/login_presenter.dart';

class GetxLoginPresenter extends GetxController implements LoginPresenter {
  final Validation validation;
  final AuthenticationUseCase authentication;
  final SaveCurrentAccountUseCase saveCurrentAccount;

  String _email;
  String _password;

  final _emailError = RxString(null);
  final _passwordError = RxString(null);
  final _mainError = RxString(null);
  final _isFormValid = RxBool(false);
  final _isLoading = RxBool(false);
  final _navigateTo = RxString(null);

  GetxLoginPresenter({
    @required this.validation,
    @required this.authentication,
    @required this.saveCurrentAccount,
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
  Stream<String> get navigateToStream => _navigateTo.stream;

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
      final account = await authentication.auth(
        AuthenticationUseCaseParams(email: _email, secret: _password),
      );
      await saveCurrentAccount.save(account);

      _navigateTo.value = '/surveys';
    } on DomainError catch (err) {
      _mainError.value = err.description;
      _isLoading.value = false;
    }
  }

  @override
  void dispose() {}
}
