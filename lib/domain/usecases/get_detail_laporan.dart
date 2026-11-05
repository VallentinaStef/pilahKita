import '../../data/laporan_repository.dart';
import '../entities/laporan.dart';

class GetDetailLaporan {
  final LaporanRepository repository;

  GetDetailLaporan(this.repository);

  Future<Laporan> call(String tiket) => repository.getDetailLaporan(tiket);
}
