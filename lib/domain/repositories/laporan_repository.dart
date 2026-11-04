import '../entities/laporan.dart';

abstract class LaporanRepository {
  Future<List<Laporan>> getDaftarLaporan();
  Future<Laporan> getDetailLaporan(String tiket);
}
