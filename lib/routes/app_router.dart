import 'package:get/get.dart';

import '../presentation/shell/home_shell.dart';
import '../presentation/pages/notifikasi_page.dart';

class AppRouter {
  AppRouter._();

  static const home = '/home';

  static final pages = [
    GetPage(
      name: home,
      page: () => const HomeShell(
        role: RolePengguna.warga,
      ),
    ),
  ];
}