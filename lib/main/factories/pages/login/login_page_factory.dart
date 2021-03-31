import 'package:flutter/material.dart';
import 'package:polls_for_devs/main/factories/pages/login/login_presenter_factory.dart';
import 'package:polls_for_devs/ui/pages/login/login_page.dart';

Widget makeLoginPage() => LoginPage(makeLoginPresenter());
