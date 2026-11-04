import 'package:flutter/material.dart';

import 'presentation/pages/report_page.dart';
import 'presentation/theme/app_theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PilahKita',
      theme: AppTheme.light,
      home: const ReportPage(),
    );
  }
}
