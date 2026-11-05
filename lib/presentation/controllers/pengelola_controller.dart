import 'package:get/get.dart';
import '../../domain/entities/laporan.dart';
import '../../data/dummy_data.dart';

class PengelolaController extends GetxController {
  final daftarLaporan = DummyData.laporan.obs;
  final kataKunci = ''.obs;

  List<Laporan> get laporanMasuk {
    return daftarLaporan.where((laporan) {
      return laporan.status == StatusLaporan.menunggu &&
          (laporan.tiket.toLowerCase().contains(
                kataKunci.value.toLowerCase(),
              ) ||
              laporan.alamat.toLowerCase().contains(
                kataKunci.value.toLowerCase(),
              ));
    }).toList();
  }

  void cariLaporan(String kata) {
    kataKunci.value = kata;
  }
}
