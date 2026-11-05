import 'package:get/get.dart';

import '../../domain/entities/laporan.dart';
import 'laporan_controller.dart';

enum FilterDashboard { mingguIni, bulanIni, semua, tanggal }

class DashboardController extends GetxController {
  final LaporanController laporanController;

  DashboardController({required this.laporanController});

  final filterAktif = FilterDashboard.bulanIni.obs;

  final tanggalMulai = Rxn<DateTime>();
  final tanggalAkhir = Rxn<DateTime>();

  // Mengambil laporan sesuai filter
  List<Laporan> get laporanTerfilter {
    final daftar = laporanController.daftarLaporan.toList();
    final sekarang = DateTime.now();

    if (filterAktif.value == FilterDashboard.semua) {
      return daftar;
    }

    if (filterAktif.value == FilterDashboard.bulanIni) {
      return daftar.where((laporan) {
        final tanggal = laporan.tanggal;
        if (tanggal == null) return false;

        return tanggal.month == sekarang.month && tanggal.year == sekarang.year;
      }).toList();
    }

    if (filterAktif.value == FilterDashboard.mingguIni) {
      final awalMinggu = DateTime(
        sekarang.year,
        sekarang.month,
        sekarang.day,
      ).subtract(Duration(days: sekarang.weekday - 1));

      final akhirMinggu = awalMinggu.add(const Duration(days: 7));

      return daftar.where((laporan) {
        final tanggal = laporan.tanggal;
        if (tanggal == null) return false;

        return !tanggal.isBefore(awalMinggu) && tanggal.isBefore(akhirMinggu);
      }).toList();
    }

    if (filterAktif.value == FilterDashboard.tanggal) {
      final mulai = tanggalMulai.value;
      final akhir = tanggalAkhir.value;

      if (mulai == null || akhir == null) return daftar;

      final batasAkhir = DateTime(akhir.year, akhir.month, akhir.day + 1);

      return daftar.where((laporan) {
        final tanggal = laporan.tanggal;
        if (tanggal == null) return false;

        return !tanggal.isBefore(mulai) && tanggal.isBefore(batasAkhir);
      }).toList();
    }

    return daftar;
  }

  // Total laporan
  int get totalLaporan => laporanTerfilter.length;

  // Jumlah laporan selesai
  int get jumlahLaporanSelesai {
    return laporanTerfilter
        .where((laporan) => laporan.status == StatusLaporan.selesai)
        .length;
  }

  // Persentase laporan selesai
  int get persentaseSelesai {
    if (totalLaporan == 0) return 0;

    return (jumlahLaporanSelesai / totalLaporan * 100).round();
  }

  // Menghitung jumlah berdasarkan jenis sampah
  int jumlahJenis(JenisSampah jenis) {
    return laporanTerfilter
        .where((laporan) => laporan.jenisSampah == jenis)
        .length;
  }

  // Menghitung persentase jenis sampah
  double persentaseJenis(JenisSampah jenis) {
    if (totalLaporan == 0) return 0;

    return jumlahJenis(jenis) / totalLaporan;
  }

  // Mengubah filter dashboard
  void ubahFilter(FilterDashboard filter) {
    filterAktif.value = filter;
  }

  // Memilih rentang tanggal
  void pilihTanggal(DateTime mulai, DateTime akhir) {
    tanggalMulai.value = mulai;
    tanggalAkhir.value = akhir;
    filterAktif.value = FilterDashboard.tanggal;
  }

  // Menghitung laporan selesai setiap minggu
  int laporanSelesaiPerMinggu(int mingguKe) {
    final sekarang = DateTime.now();

    final awalMingguIni = DateTime(
      sekarang.year,
      sekarang.month,
      sekarang.day,
    ).subtract(Duration(days: sekarang.weekday - 1));

    final awalMinggu = awalMingguIni.subtract(
      Duration(days: 7 * (5 - mingguKe)),
    );

    final akhirMinggu = awalMinggu.add(const Duration(days: 7));

    return laporanTerfilter.where((laporan) {
      final tanggal = laporan.tanggal;

      if (tanggal == null) return false;

      return laporan.status == StatusLaporan.selesai &&
          !tanggal.isBefore(awalMinggu) &&
          tanggal.isBefore(akhirMinggu);
    }).length;
  }

  // Jumlah laporan selesai tertinggi
  int get jumlahSelesaiTerbanyakMingguan {
    int tertinggi = 0;

    for (int i = 1; i <= 5; i++) {
      final jumlah = laporanSelesaiPerMinggu(i);

      if (jumlah > tertinggi) {
        tertinggi = jumlah;
      }
    }

    return tertinggi;
  }
}
