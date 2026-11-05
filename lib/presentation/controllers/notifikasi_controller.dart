import 'package:get/get.dart';

import '../../domain/entities/notifikasi.dart';
import '../../domain/usecases/get_daftar_notifikasi.dart';

class NotifikasiController extends GetxController {
  final GetDaftarNotifikasi getDaftarNotifikasi;

  NotifikasiController({required this.getDaftarNotifikasi});

  final daftarNotifikasi = <Notifikasi>[].obs;
  final isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    muatNotifikasi();
  }

  Future<void> muatNotifikasi() async {
    isLoading.value = true;
    daftarNotifikasi.value = await getDaftarNotifikasi();
    isLoading.value = false;
  }

  int get jumlahBelumDibaca =>
      daftarNotifikasi.where((n) => !n.dibaca).length;

  List<String> get grupList {
    final grup = <String>[];
    for (final n in daftarNotifikasi) {
      if (!grup.contains(n.grup)) grup.add(n.grup);
    }
    return grup;
  }

  List<Notifikasi> perGrup(String grup) =>
      daftarNotifikasi.where((n) => n.grup == grup).toList();
}
