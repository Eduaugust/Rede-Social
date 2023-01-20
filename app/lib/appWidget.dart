import 'package:app/modules/login/login_page.dart';
import 'package:flutter/material.dart';

import 'modules/home/home_page.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(routes: {
      '/home': (context) => HomePage(),
      '/login': (context) => const LoginPage()
    }, initialRoute: '/sign_up');
  }
}
