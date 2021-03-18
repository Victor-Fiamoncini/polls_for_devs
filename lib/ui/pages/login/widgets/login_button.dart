import 'package:flutter/material.dart';
import 'package:polls_for_devs/ui/pages/login/login_presenter.dart';
import 'package:provider/provider.dart';

class LoginButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final presenter = Provider.of<LoginPresenter>(context);

    return StreamBuilder<bool>(
      stream: presenter.isFormValidStream,
      builder: (context, snapshot) {
        return ElevatedButton(
          onPressed: snapshot.data == true ? presenter.auth : null,
          style: Theme.of(context).elevatedButtonTheme.style,
          child: const Text('Entrar'),
        );
      },
    );
  }
}
