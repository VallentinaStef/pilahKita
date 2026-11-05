import 'package:get/get.dart';

import '../../domain/entities/laporan.dart';
import '../../data/dummy_data.dart';

enum FilterLaporan { semua, menunggu, diproses, selesai, ditolak }

class PengelolaController extends GetxController {
  final daftarLaporan = DummyData.laporan.obs;
  final kataKunci = ''.obs;
  final filterAktif = FilterLaporan.semua.obs;

  List<Laporan> get laporanMasuk {
    return daftarLaporan.where((laporan) {
      final cocokKata =
          laporan.tiket.toLowerCase().contains(kataKunci.value.toLowerCase()) ||
          laporan.alamat.toLowerCase().contains(kataKunci.value.toLowerCase());

      final cocokStatus = switch (filterAktif.value) {
        FilterLaporan.semua => true,
        FilterLaporan.menunggu => laporan.status == StatusLaporan.menunggu,
        FilterLaporan.diproses => laporan.status == StatusLaporan.diproses,
        FilterLaporan.selesai => laporan.status == StatusLaporan.selesai,
        FilterLaporan.ditolak => laporan.status == StatusLaporan.ditolak,
      };

      return cocokKata && cocokStatus;
    }).toList();
  }

  int jumlahStatus(StatusLaporan status) {
    return daftarLaporan.where((laporan) => laporan.status == status).length;
  }

  void cariLaporan(String kata) {
    kataKunci.value = kata;
  }

  void ubahFilter(FilterLaporan filter) {
    filterAktif.value = filter;
  }
}
