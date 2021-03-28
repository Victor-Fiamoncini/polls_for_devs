import 'dart:async';

import 'package:meta/meta.dart';
import 'package:polls_for_devs/presentation/protocols/validation.dart';

class LoginState {
  String emailError;
  bool get isFormValid => false;
}

class StreamLoginPresenter {
  final Validation validation;

  final _controller = StreamController<LoginState>.broadcast();
  final _state = LoginState();

  StreamLoginPresenter({@required this.validation});

  Stream<String> get emailErrorStream {
    return _controller.stream.map((state) => state.emailError).distinct();
  }

  Stream<bool> get isFormValidStream {
    return _controller.stream.map((state) => state.isFormValid).distinct();
  }

  void validateEmail(String email) {
    _state.emailError = validation.validate(field: 'email', value: email);

    _controller.add(_state);
  }
}
