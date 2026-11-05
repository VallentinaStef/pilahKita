import 'package:get/get.dart';

import '../data/laporan_repository.dart';
import '../domain/usecases/get_daftar_laporan.dart';
import '../domain/usecases/get_detail_laporan.dart';
import '../presentation/controllers/laporan_controller.dart';

class DependencyInjection {
  DependencyInjection._();

  static void init() {
    final laporanRepo = LaporanRepositoryImpl();

    final getDaftarLaporan = GetDaftarLaporan(laporanRepo);
    final getDetailLaporan = GetDetailLaporan(laporanRepo);

    Get.put(
      LaporanController(
        getDaftarLaporan: getDaftarLaporan,
        getDetailLaporan: getDetailLaporan,
      ),
      permanent: true,
    );
  }
}