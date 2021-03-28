import 'dart:async';

import 'package:meta/meta.dart';
import 'package:polls_for_devs/domain/use_cases/authentication_use_case.dart';
import 'package:polls_for_devs/presentation/protocols/validation.dart';

class LoginState {
  String email;
  String password;
  String emailError;
  String passwordError;

  bool get isFormValid =>
      emailError == null &&
      passwordError == null &&
      email != null &&
      password != null;
}

class StreamLoginPresenter {
  final Validation validation;
  final AuthenticationUseCase authentication;

  final _controller = StreamController<LoginState>.broadcast();
  final _state = LoginState();

  StreamLoginPresenter({
    @required this.validation,
    @required this.authentication,
  });

  Stream<String> get emailErrorStream {
    return _controller.stream.map((state) => state.emailError).distinct();
  }

  Stream<String> get passwordErrorStream {
    return _controller.stream.map((state) => state.passwordError).distinct();
  }

  Stream<bool> get isFormValidStream {
    return _controller.stream.map((state) => state.isFormValid).distinct();
  }

  void _update() => _controller.add(_state);

  void validateEmail(String email) {
    _state.email = email;
    _state.emailError = validation.validate(field: 'email', value: email);

    _update();
  }

  void validatePassword(String password) {
    _state.password = password;
    _state.passwordError = validation.validate(
      field: 'password',
      value: password,
    );

    _update();
  }

  Future<void> auth() async {
    await authentication.auth(
      AuthenticationUseCaseParams(email: _state.email, secret: _state.password),
    );
  }
}
