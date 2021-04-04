import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:polls_for_devs/ui/pages/login/login_presenter.dart';
import 'package:polls_for_devs/ui/pages/login/widgets/email_input.dart';
import 'package:polls_for_devs/ui/pages/login/widgets/login_button.dart';
import 'package:polls_for_devs/ui/pages/login/widgets/password_input.dart';
import 'package:polls_for_devs/ui/widgets/error_message.dart';
import 'package:polls_for_devs/ui/widgets/headline1.dart';
import 'package:polls_for_devs/ui/widgets/loading.dart';
import 'package:polls_for_devs/ui/widgets/login_header.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatelessWidget {
  final LoginPresenter presenter;

  const LoginPage(this.presenter);

  @override
  Widget build(BuildContext context) {
    void _hideKeyboard() {
      final currentFocus = FocusScope.of(context);

      if (!currentFocus.hasPrimaryFocus) {
        currentFocus.unfocus();
      }
    }

    return Scaffold(
      body: Builder(
        builder: (context) {
          presenter.isLoadingStream.listen((isLoading) {
            if (isLoading) {
              showLoading(context);
            } else {
              hideLoading(context);
            }
          });

          presenter.mainErrorStream.listen((error) {
            if (error != null) {
              showErrorMessage(context, error);
            }
          });

          presenter.navigateToStream.listen((page) {
            if (page?.isNotEmpty == true) {
              Get.offAllNamed(page);
            }
          });

          return GestureDetector(
            onTap: _hideKeyboard,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  LoginHeader(),
                  const Headline1(text: 'login'),
                  Padding(
                    padding: const EdgeInsets.all(32),
                    child: Provider<LoginPresenter>(
                      create: (_) => presenter,
                      child: Form(
                        child: Column(
                          children: [
                            EmailInput(),
                            Padding(
                              padding: const EdgeInsets.only(
                                top: 8,
                                bottom: 32,
                              ),
                              child: PasswordInput(),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 8),
                              child: LoginButton(),
                            ),
                            TextButton.icon(
                              onPressed: () {},
                              icon: const Icon(Icons.person),
                              label: const Text('Criar Conta'),
                            )
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
