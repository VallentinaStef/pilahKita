import 'package:get/get.dart';

import '../../domain/entities/laporan.dart';
import '../../domain/entities/petugas.dart';
import '../../data/dummy_data.dart';
import '../../data/dummy_petugas.dart';

enum FilterLaporan { semua, menunggu, diproses, selesai, ditolak }

class PengelolaController extends GetxController {
  final daftarLaporan = DummyData.laporan.obs;
  final daftarPetugas = DummyPetugas.daftar.obs;

  final kataKunci = ''.obs;
  final filterAktif = FilterLaporan.semua.obs;

  // Pencarian dan filter laporan
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

  // Mengambil detail laporan berdasarkan tiket
  Laporan? cariDetailLaporan(String tiket) {
    try {
      return daftarLaporan.firstWhere((laporan) => laporan.tiket == tiket);
    } catch (_) {
      return null;
    }
  }

  // Memperbarui data laporan
  void perbaruiLaporan(Laporan laporanBaru) {
    final index = daftarLaporan.indexWhere(
      (item) => item.tiket == laporanBaru.tiket,
    );

    if (index != -1) {
      daftarLaporan[index] = laporanBaru;
      daftarLaporan.refresh();
    }
  }

  // Mengambil daftar petugas
  List<Petugas> get petugasTersedia {
    return daftarPetugas;
  }

  // Menerima laporan dan menugaskan petugas
  void terimaLaporan(String tiket, Petugas petugas) {
    final laporan = cariDetailLaporan(tiket);

    if (laporan == null || laporan.status != StatusLaporan.menunggu) {
      return;
    }

    final laporanBaru = laporan.copyWith(
      status: StatusLaporan.diproses,
      petugas: petugas.nama,
      timeline: [
        ...laporan.timeline,
        LangkahStatus(
          judul: 'Ditugaskan kepada ${petugas.nama}',
          waktu: _waktuSekarang(),
          tercapai: true,
        ),
      ],
    );

    perbaruiLaporan(laporanBaru);
  }

  // Menolak laporan
  void tolakLaporan(String tiket, String alasan) {
    final laporan = cariDetailLaporan(tiket);

    if (laporan == null ||
        laporan.status != StatusLaporan.menunggu ||
        alasan.trim().isEmpty) {
      return;
    }

    final laporanBaru = laporan.copyWith(
      status: StatusLaporan.ditolak,
      alasanPenolakan: alasan.trim(),
      timeline: [
        ...laporan.timeline,
        LangkahStatus(
          judul: 'Ditolak Pengelola',
          waktu: _waktuSekarang(),
          tercapai: true,
        ),
      ],
    );

    perbaruiLaporan(laporanBaru);
  }

  String _waktuSekarang() {
    final sekarang = DateTime.now();

    final jam = sekarang.hour.toString().padLeft(2, '0');
    final menit = sekarang.minute.toString().padLeft(2, '0');

    return '${sekarang.day}/${sekarang.month}/${sekarang.year}, $jam:$menit';
  }

  void tugaskanUlang(String tiket, Petugas petugas) {
    final laporan = cariDetailLaporan(tiket);

    if (laporan == null || laporan.status != StatusLaporan.diproses) {
      return;
    }

    final laporanBaru = laporan.copyWith(
      petugas: petugas.nama,
      timeline: [
        ...laporan.timeline,
        LangkahStatus(
          judul: 'Penugasan ulang kepada ${petugas.nama}',
          waktu: _waktuSekarang(),
          tercapai: true,
        ),
      ],
    );

    perbaruiLaporan(laporanBaru);
  }
}
