import '../entities/laporan.dart';
import '../repositories/laporan_repository.dart';

class GetDetailLaporan {
  final LaporanRepository repository;

  GetDetailLaporan(this.repository);

  Future<Laporan> call(String tiket) => repository.getDetailLaporan(tiket);
}
