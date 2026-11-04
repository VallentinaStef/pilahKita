import '../entities/laporan.dart';
import '../repositories/laporan_repository.dart';

class GetDaftarLaporan {
  final LaporanRepository repository;

  GetDaftarLaporan(this.repository);

  Future<List<Laporan>> call() => repository.getDaftarLaporan();
}
