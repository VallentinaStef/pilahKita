import '../../domain/entities/laporan.dart';
import '../../data/dummy_data.dart';

abstract class LaporanRepository {
  Future<List<Laporan>> getDaftarLaporan();
  Future<Laporan> getDetailLaporan(String tiket);
}

class LaporanRepositoryImpl implements LaporanRepository {
  @override
  Future<List<Laporan>> getDaftarLaporan() async {
    await Future.delayed(const Duration(milliseconds: 400));
    return DummyData.laporan;
  }

  @override
  Future<Laporan> getDetailLaporan(String tiket) async {
    return DummyData.laporan.firstWhere(
      (l) => l.tiket == tiket,
      orElse: () => DummyData.laporan.first,
    );
  }
}
