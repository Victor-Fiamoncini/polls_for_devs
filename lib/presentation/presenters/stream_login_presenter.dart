import 'dart:async';

import 'package:meta/meta.dart';
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

  final _controller = StreamController<LoginState>.broadcast();
  final _state = LoginState();

  StreamLoginPresenter({@required this.validation});

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
}
