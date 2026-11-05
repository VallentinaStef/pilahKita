import '../entities/notifikasi.dart';
import '../../data/notifikasi_repository.dart';

class GetDaftarNotifikasi {
  final NotifikasiRepository repository;

  GetDaftarNotifikasi(this.repository);

  Future<List<Notifikasi>> call() => repository.getDaftarNotifikasi();
}
