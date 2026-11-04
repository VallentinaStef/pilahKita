import 'package:flutter/material.dart';
import 'package:get/get.dart';


import 'core/config/app_theme.dart';
import 'di/dependency_injection.dart';
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
      initialRoute: AppRouter.home,
    );
  }
}


