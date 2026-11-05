import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/pengelola_controller.dart';
import '../../themes/app_colors.dart';
import '../../../domain/entities/petugas.dart';
import 'detail_laporan_pengelola_page.dart' show PetaLaporanPainter;

class DetailLaporanBerjalanPage extends StatelessWidget {
  final String tiket;

  DetailLaporanBerjalanPage({super.key, required this.tiket});

  final controller = Get.find<PengelolaController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final laporan = controller.cariDetailLaporan(tiket);

      if (laporan == null) {
        return const Scaffold(
          body: Center(child: Text('Laporan tidak ditemukan')),
        );
      }

      return Scaffold(
        backgroundColor: AppColors.background,
        body: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.fromLTRB(20, 10, 20, 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Peta lokasi
                      ClipRRect(
                        borderRadius: BorderRadius.circular(24),
                        child: SizedBox(
                          height: 140,
                          width: double.infinity,
                          child: Stack(
                            children: [
                              Positioned.fill(
                                child: CustomPaint(
                                  painter: PetaLaporanPainter(),
                                ),
                              ),
                              Positioned(
                                top: 12,
                                left: 12,
                                child: CircleAvatar(
                                  backgroundColor: Colors.white,
                                  radius: 17,
                                  child: IconButton(
                                    padding: EdgeInsets.zero,
                                    iconSize: 18,
                                    onPressed: () => Get.back(),
                                    icon: const Icon(
                                      Icons.arrow_back_ios_new,
                                      color: AppColors.primary,
                                    ),
                                  ),
                                ),
                              ),
                              const Center(
                                child: Icon(
                                  Icons.location_on,
                                  color: Color(0xFFC2410C),
                                  size: 32,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      const SizedBox(height: 12),

                      // Nomor tiket dan status
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            laporan.tiket,
                            style: const TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.w800,
                              color: AppColors.primary,
                            ),
                          ),
                          _statusChip(),
                        ],
                      ),

                      const SizedBox(height: 10),

                      // Alamat
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Icon(
                            Icons.location_on,
                            color: AppColors.primary,
                            size: 19,
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  laporan.alamat,
                                  style: const TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.primary,
                                  ),
                                ),
                                Text(
                                  '${laporan.jenisLabel}, volume ${laporan.volumeLabel}',
                                  style: const TextStyle(
                                    fontSize: 11,
                                    color: AppColors.textSecondary,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 16),

                      // Informasi petugas
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(13),
                        decoration: BoxDecoration(
                          color: AppColors.surface,
                          borderRadius: BorderRadius.circular(22),
                        ),
                        child: Row(
                          children: [
                            CircleAvatar(
                              radius: 18,
                              backgroundColor: AppColors.accent,
                              child: Text(
                                (laporan.petugas ?? '-')[0].toUpperCase(),
                                style: const TextStyle(
                                  color: AppColors.primary,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    laporan.petugas ?? 'Belum ditugaskan',
                                    style: const TextStyle(
                                      color: AppColors.primary,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 13,
                                    ),
                                  ),
                                  Text(
                                    'Ditugaskan ${laporan.timeline.isNotEmpty ? laporan.timeline.last.waktu : '-'}',
                                    style: const TextStyle(
                                      color: AppColors.textSecondary,
                                      fontSize: 11,
                                    ),
                                  ),
                                  const Text(
                                    'Sedang dikerjakan',
                                    style: TextStyle(
                                      color: AppColors.textSecondary,
                                      fontSize: 11,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 12),

                      // Foto warga
                      Container(
                        width: double.infinity,
                        height: 90,
                        decoration: BoxDecoration(
                          color: const Color(0xFFD7E8CE),
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: Colors.white, width: 4),
                        ),
                        clipBehavior: Clip.antiAlias,
                        child:
                            laporan.fotoWarga != null
                                ? Image.asset(
                                  laporan.fotoWarga!,
                                  fit: BoxFit.cover,
                                  errorBuilder:
                                      (_, __, ___) => const Center(
                                        child: Text('Foto dari warga'),
                                      ),
                                )
                                : const Center(
                                  child: Text(
                                    'Foto dari warga',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.primary,
                                    ),
                                  ),
                                ),
                      ),
                    ],
                  ),
                ),
              ),

              // Tombol penugasan ulang
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 8, 20, 16),
                child: SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: OutlinedButton(
                    onPressed: () => _dialogPenugasan(context),
                    style: OutlinedButton.styleFrom(
                      backgroundColor: AppColors.surface,
                      foregroundColor: AppColors.primary,
                      side: const BorderSide(
                        color: AppColors.primary,
                        width: 1.5,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: const Text(
                      'Tugaskan ulang',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }

  Widget _statusChip() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.processing),
        borderRadius: BorderRadius.circular(8),
      ),
      child: const Text(
        'Dalam proses',
        style: TextStyle(
          color: AppColors.processing,
          fontSize: 10,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  void _dialogPenugasan(BuildContext context) {
    Petugas? terpilih;

    final petugas = controller.petugasTersedia;

    if (petugas.isEmpty) {
      Get.snackbar('Petugas kosong', 'Belum ada petugas tersedia');
      return;
    }

    terpilih =
        petugas.firstWhereOrNull(
          (item) => item.nama == controller.cariDetailLaporan(tiket)?.petugas,
        ) ??
        petugas.first;

    Get.dialog(
      StatefulBuilder(
        builder: (context, setState) {
          return AlertDialog(
            title: const Text('Tugaskan Ulang'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children:
                  petugas.map((item) {
                    return RadioListTile<Petugas>(
                      contentPadding: EdgeInsets.zero,
                      title: Text(item.nama),
                      subtitle: Text(item.wilayah),
                      value: item,
                      groupValue: terpilih,
                      onChanged: (value) {
                        setState(() => terpilih = value);
                      },
                    );
                  }).toList(),
            ),
            actions: [
              TextButton(
                onPressed: () => Get.back(),
                child: const Text('Batal'),
              ),
              ElevatedButton(
                onPressed:
                    terpilih == null
                        ? null
                        : () {
                          controller.tugaskanUlang(tiket, terpilih!);

                          Get.back();

                          Get.snackbar(
                            'Penugasan diperbarui',
                            'Laporan ditugaskan kepada ${terpilih!.nama}',
                          );
                        },
                child: const Text('Simpan'),
              ),
            ],
          );
        },
      ),
    );
  }
}
