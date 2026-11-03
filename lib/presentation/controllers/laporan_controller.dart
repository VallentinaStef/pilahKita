import 'package:get/get.dart';

import '../../domain/entities/laporan.dart';
import '../../domain/usecases/get_daftar_laporan.dart';
import '../../domain/usecases/get_detail_laporan.dart';

enum FilterRiwayat { semua, aktif, selesai, ditolak }

class LaporanController extends GetxController {
  final GetDaftarLaporan getDaftarLaporan;
  final GetDetailLaporan getDetailLaporan;

  LaporanController({
    required this.getDaftarLaporan,
    required this.getDetailLaporan,
  });

  final daftarLaporan = <Laporan>[].obs;
  final detailLaporan = Rxn<Laporan>();
  final isLoading = false.obs;

  final filterAktif = FilterRiwayat.semua.obs;

  @override
  void onInit() {
    super.onInit();
    muatLaporan();
  }

  Future<void> muatLaporan() async {
    isLoading.value = true;
    daftarLaporan.value = await getDaftarLaporan();
    isLoading.value = false;
  }

  Future<void> muatDetail(String tiket) async {
    isLoading.value = true;
    detailLaporan.value = await getDetailLaporan(tiket);
    isLoading.value = false;
  }

  void ubahFilter(FilterRiwayat filter) {
    filterAktif.value = filter;
  }

  List<Laporan> get laporanTersaring {
    return switch (filterAktif.value) {
      FilterRiwayat.semua => daftarLaporan,
      FilterRiwayat.aktif => daftarLaporan
          .where((l) =>
              l.status == StatusLaporan.menunggu ||
              l.status == StatusLaporan.diproses)
          .toList(),
      FilterRiwayat.selesai =>
        daftarLaporan.where((l) => l.status == StatusLaporan.selesai).toList(),
      FilterRiwayat.ditolak =>
        daftarLaporan.where((l) => l.status == StatusLaporan.ditolak).toList(),
    };
  }

  List<Laporan> get laporanSaya {
    if (daftarLaporan.length < 2) return daftarLaporan;
    return daftarLaporan.take(2).toList();
  }
}
