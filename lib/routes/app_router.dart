import 'package:get/get.dart';

import '../presentation/pages/detail_laporan_page.dart';
import '../presentation/shell/home_shell.dart';
import '../presentation/pages/pengelola/laporan_masuk_page.dart';
import '../presentation/shell/pengelola_shell.dart';

class AppRouter {
  AppRouter._();

  static const String home = '/';

  static List<GetPage> get pages => [
    GetPage(name: home, page: () => const HomeShell()),
    GetPage(
      name: '/detail-laporan',
      page: () {
        final tiket = Get.parameters['tiket'] ?? '';
        return DetailLaporanPage(tiket: tiket);
      },
    ),
    GetPage(name: '/pengelola/laporan-masuk', page: () => LaporanMasukPage()),
    GetPage(name: '/pengelola', page: () => const PengelolaShell()),
  ];
}
