import 'dart:async';

import 'package:meta/meta.dart';
import 'package:polls_for_devs/domain/helpers/domain_error.dart';
import 'package:polls_for_devs/domain/use_cases/authentication_use_case.dart';
import 'package:polls_for_devs/presentation/protocols/validation.dart';
import 'package:polls_for_devs/ui/pages/login/login_presenter.dart';

class LoginState {
  String email;
  String password;
  String emailError;
  String mainError;
  String passwordError;
  bool isLoading = false;

  bool get isFormValid =>
      emailError == null &&
      passwordError == null &&
      email != null &&
      password != null;
}

class StreamLoginPresenter implements LoginPresenter {
  final Validation validation;
  final AuthenticationUseCase authentication;

  var _controller = StreamController<LoginState>.broadcast();
  final _state = LoginState();

  StreamLoginPresenter({
    @required this.validation,
    @required this.authentication,
  });

  @override
  Stream<String> get emailErrorStream {
    return _controller?.stream?.map((state) => state.emailError)?.distinct();
  }

  @override
  Stream<String> get passwordErrorStream {
    return _controller?.stream?.map((state) => state.passwordError)?.distinct();
  }

  @override
  Stream<String> get mainErrorStream {
    return _controller?.stream?.map((state) => state.mainError)?.distinct();
  }

  @override
  Stream<bool> get isFormValidStream {
    return _controller?.stream?.map((state) => state.isFormValid)?.distinct();
  }

  @override
  Stream<bool> get isLoadingStream {
    return _controller?.stream?.map((state) => state.isLoading)?.distinct();
  }

  @override
  // TODO: implement navigateToStream
  Stream<String> get navigateToStream => throw UnimplementedError();

  void _update() => _controller?.add(_state);

  @override
  void validateEmail(String email) {
    _state.email = email;
    _state.emailError = validation.validate(field: 'email', value: email);

    _update();
  }

  @override
  void validatePassword(String password) {
    _state.password = password;
    _state.passwordError = validation.validate(
      field: 'password',
      value: password,
    );

    _update();
  }

  @override
  Future<void> auth() async {
    _state.isLoading = true;
    _update();

    try {
      await authentication.auth(
        AuthenticationUseCaseParams(
            email: _state.email, secret: _state.password),
      );
    } on DomainError catch (err) {
      _state.mainError = err.description;
    }

    _state.isLoading = false;
    _update();
  }

  @override
  void dispose() {
    _controller?.close();
    _controller = null;
  }
}
