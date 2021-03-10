import 'package:flutter/material.dart';
import 'package:polls_for_devs/ui/pages/login_page.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Polls For Devs',
      debugShowCheckedModeBanner: false,
      home: LoginPage(),
    );
  }
}
