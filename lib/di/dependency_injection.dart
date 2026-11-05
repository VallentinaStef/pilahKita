import 'package:get/get.dart';

import '../data/laporan_repository.dart';
import '../data/notifikasi_repository.dart';
import '../domain/usecases/get_daftar_laporan.dart';
import '../domain/usecases/get_detail_laporan.dart';
import '../domain/usecases/get_daftar_notifikasi.dart';
import '../presentation/controllers/laporan_controller.dart';
import '../presentation/controllers/notifikasi_controller.dart';

class DependencyInjection {
  DependencyInjection._();

  static void init() {
    final laporanRepo = LaporanRepositoryImpl();
    final notifikasiRepo = NotifikasiRepositoryImpl();

    final getDaftarLaporan = GetDaftarLaporan(laporanRepo);
    final getDetailLaporan = GetDetailLaporan(laporanRepo);
    final getDaftarNotifikasi = GetDaftarNotifikasi(notifikasiRepo);

    Get.put(
      LaporanController(
        getDaftarLaporan: getDaftarLaporan,
        getDetailLaporan: getDetailLaporan,
      ),
      permanent: true,
    );

    Get.put(
      NotifikasiController(
        getDaftarNotifikasi: getDaftarNotifikasi,
      ),
      permanent: true,
    );
  }
}