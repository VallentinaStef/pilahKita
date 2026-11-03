import 'package:flutter/material.dart';

import 'presentation/pages/login_page.dart';
import 'presentation/theme/app_theme.dart';

void main() {
  runApp(const PilahKitaApp());
}

class PilahKitaApp extends StatelessWidget {
  const PilahKitaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PilahKita',
      debugShowCheckedModeBanner: false,
      theme: appTheme,
      home: const LoginPage(),
    );
  }
}
