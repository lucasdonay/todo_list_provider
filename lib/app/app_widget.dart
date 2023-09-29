import 'package:flutter/material.dart';

import 'modules/splash/splash_page.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Todo list Provider',
      home: SplashPage(),
    );
  }
}
