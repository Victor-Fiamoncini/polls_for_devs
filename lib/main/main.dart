import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:polls_for_devs/main/factories/pages/login/login_page_factory.dart';
import 'package:polls_for_devs/ui/themes/default_theme.dart';
import 'package:provider/provider.dart';

void main() {
  Provider.debugCheckInvalidValueType = null;

  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);

    return GetMaterialApp(
      title: 'Polls For Devs',
      debugShowCheckedModeBanner: false,
      theme: makeDefaultTheme(),
      initialRoute: '/login',
      getPages: [
        GetPage(name: '/login', page: makeLoginPage),
        GetPage(
          name: '/surveys',
          page: () => const Scaffold(body: Text('Enquetes')),
        ),
      ],
    );
  }
}
