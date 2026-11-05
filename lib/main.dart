import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'presentation/themes/app_theme.dart';
import 'di/dependency_injection.dart';
import 'presentation/pages/auth/login_page.dart';
import 'routes/app_router.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  DependencyInjection.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'PilahKita',
      theme: AppTheme.light,
      getPages: AppRouter.pages,
      home: const LoginPage(),
    );
  }
}