import '../../data/laporan_repository.dart';
import '../../domain/entities/laporan.dart';
class GetDaftarLaporan {
  final LaporanRepository repository;

  GetDaftarLaporan(this.repository);

  Future<List<Laporan>> call() => repository.getDaftarLaporan();
}
