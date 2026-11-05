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
  final isLoadingDetail = false.obs;

  final filterAktif = FilterRiwayat.semua.obs;

  @override
  void onInit() {
    super.onInit();
    muatLaporan();
  }

  Future<void> muatLaporan() async {
    isLoading.value = true;
    try {
      final data = List<Laporan>.from(await getDaftarLaporan());
      data.sort((a, b) {
        final tanggalA = a.tanggal;
        final tanggalB = b.tanggal;
        if (tanggalA == null && tanggalB == null) return 0;
        if (tanggalA == null) return 1;
        if (tanggalB == null) return -1;
        return tanggalB.compareTo(tanggalA);
      });
      daftarLaporan.value = data;
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> muatDetail(String tiket) async {
    for (final laporan in daftarLaporan) {
      if (laporan.tiket == tiket) {
        detailLaporan.value = laporan;
        isLoadingDetail.value = false;
        return;
      }
    }

    isLoadingDetail.value = true;
    try {
      detailLaporan.value = await getDetailLaporan(tiket);
    } finally {
      isLoadingDetail.value = false;
    }
  }

  void ubahFilter(FilterRiwayat filter) {
    filterAktif.value = filter;
  }

  List<Laporan> get laporanTersaring {
    return switch (filterAktif.value) {
      FilterRiwayat.semua => daftarLaporan,
      FilterRiwayat.aktif =>
        daftarLaporan
            .where(
              (l) =>
                  l.status == StatusLaporan.menunggu ||
                  l.status == StatusLaporan.diproses,
            )
            .toList(),
      FilterRiwayat.selesai =>
        daftarLaporan.where((l) => l.status == StatusLaporan.selesai).toList(),
      FilterRiwayat.ditolak =>
        daftarLaporan.where((l) => l.status == StatusLaporan.ditolak).toList(),
    };
  }

  List<Laporan> get laporanSaya {
    return daftarLaporan
        .where(
          (l) =>
              l.status == StatusLaporan.menunggu ||
              l.status == StatusLaporan.diproses,
        )
        .toList();
  }

  int get jumlahSelesai =>
      daftarLaporan.where((l) => l.status == StatusLaporan.selesai).length;
}
