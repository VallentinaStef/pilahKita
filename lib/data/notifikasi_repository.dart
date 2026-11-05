import '../domain/entities/notifikasi.dart';
import 'dummy_data.dart';

abstract class NotifikasiRepository {
  Future<List<Notifikasi>> getDaftarNotifikasi();
}

class NotifikasiRepositoryImpl implements NotifikasiRepository {
  final bool rolePetugas;

  NotifikasiRepositoryImpl({this.rolePetugas = false});

  @override
  Future<List<Notifikasi>> getDaftarNotifikasi() async {
    await Future.delayed(const Duration(milliseconds: 400));
    return rolePetugas
        ? DummyData.notifikasiPetugas
        : DummyData.notifikasiWarga;
  }
}