import 'package:flutter/material.dart';
import 'package:polls_for_devs/ui/components/headline1.dart';
import 'package:polls_for_devs/ui/components/login_header.dart';
import 'package:polls_for_devs/ui/pages/login/login_presenter.dart';

class LoginPage extends StatelessWidget {
  final LoginPresenter loginPresenter;

  const LoginPage(this.loginPresenter);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            LoginHeader(),
            const Headline1(text: 'login'),
            Padding(
              padding: const EdgeInsets.all(32),
              child: Form(
                child: Column(
                  children: [
                    StreamBuilder<String>(
                      stream: loginPresenter.emailErrorStream,
                      builder: (context, snapshot) {
                        return TextFormField(
                          decoration: InputDecoration(
                            labelText: 'Email',
                            icon: Icon(
                              Icons.email,
                              color: Theme.of(context).primaryColor,
                            ),
                            errorText: snapshot.data,
                          ),
                          keyboardType: TextInputType.emailAddress,
                          onChanged: loginPresenter.validateEmail,
                        );
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8, bottom: 32),
                      child: TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Senha',
                          icon: Icon(
                            Icons.lock,
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                        obscureText: true,
                        onChanged: loginPresenter.validatePassword,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: ElevatedButton(
                        onPressed: null,
                        style: Theme.of(context).elevatedButtonTheme.style,
                        child: const Text('ENTRAR'),
                      ),
                    ),
                    TextButton.icon(
                      onPressed: () {},
                      icon: const Icon(Icons.person),
                      label: const Text('Criar Conta'),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
