import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:polls_for_devs/data/services/remote_authentication_service.dart';
import 'package:polls_for_devs/infra/http/http_adapter.dart';
import 'package:polls_for_devs/presentation/presenters/stream_login_presenter.dart';
import 'package:polls_for_devs/ui/pages/login/login_page.dart';
import 'package:polls_for_devs/validation/validators/email_validator.dart';
import 'package:polls_for_devs/validation/validators/required_field_validator.dart';
import 'package:polls_for_devs/validation/validators/validator_composite.dart';

Widget makeLoginPage() {
  final client = Client();
  final httpAdapter = HttpAdapter(client);

  const url = 'http://fordevs.herokuapp.com/api/login';

  final authentication = RemoteAuthenticationService(
    httpClient: httpAdapter,
    url: url,
  );

  final validation = ValidatorComposite([
    RequiredFieldValidator('email'),
    EmailValidator('email'),
    RequiredFieldValidator('password'),
  ]);

  final loginPresenter = StreamLoginPresenter(
    authentication: authentication,
    validation: validation,
  );

  return LoginPage(loginPresenter);
}
