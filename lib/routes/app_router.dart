import 'package:get/get.dart';

import '../presentation/pages/detail_laporan_page.dart';
import '../presentation/shell/home_shell.dart';

class AppRouter {
  AppRouter._();

  static const String home = '/';

  static List<GetPage> get pages => [
        GetPage(
          name: home,
          page: () => const HomeShell(),
        ),
        GetPage(
          name: '/detail-laporan',
          page: () {
            final tiket = Get.parameters['tiket'] ?? '';
            return DetailLaporanPage(tiket: tiket);
          },
        ),
      ];
}
