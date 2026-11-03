import '../../domain/entities/laporan.dart';
import '../../domain/repositories/laporan_repository.dart';
import '../datasources/dummy_data.dart';

class LaporanRepositoryImpl implements LaporanRepository {
  @override
  Future<List<Laporan>> getDaftarLaporan() async {
    await Future.delayed(const Duration(milliseconds: 400));
    return DummyData.laporan;
  }

  @override
  Future<Laporan> getDetailLaporan(String tiket) async {
    await Future.delayed(const Duration(milliseconds: 250));
    return DummyData.laporan.firstWhere(
      (l) => l.tiket == tiket,
      orElse: () => DummyData.laporan.first,
    );
  }
}
