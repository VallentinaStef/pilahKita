import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../themes/app_theme.dart';
import '../controllers/laporan_controller.dart';
import '../widgets/laporan_card.dart';
import 'detail_laporan_page.dart';

class RiwayatPage extends GetView<LaporanController> {
  const RiwayatPage({super.key});

  static const _filters = <(String, FilterRiwayat)>[
    ('Semua', FilterRiwayat.semua),
    ('Aktif', FilterRiwayat.aktif),
    ('Selesai', FilterRiwayat.selesai),
    ('Ditolak', FilterRiwayat.ditolak),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.fromLTRB(16, 32, 16, 12),
            child: Text(
              'Riwayat laporan',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
          SizedBox(
            height: 48,
            child: Obx(() {
              final filterSekarang = controller.filterAktif.value;
              return ListView(
                scrollDirection: Axis.horizontal,
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                children: _filters.map((f) {
                  final (label, status) = f;
                  final dipilih = filterSekarang == status;
                  return Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: InkWell(
                      onTap: () => controller.ubahFilter(status),
                      borderRadius: BorderRadius.circular(20),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 18, vertical: 8),
                        decoration: BoxDecoration(
                          color:
                              dipilih ? AppTheme.accent : AppTheme.primary,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          label,
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: dipilih
                                ? AppTheme.primary
                                : Colors.white,
                          ),
                        ),
                      ),
                    ),
                  );
                }).toList(),
              );
            }),
          ),
          Expanded(
            child: Obx(() {
              if (controller.isLoading.value) {
                return const Center(child: CircularProgressIndicator());
              }
              final laporan = controller.laporanTersaring;
              if (laporan.isEmpty) {
                return const Center(
                  child: Text(
                    'Tidak ada laporan pada filter ini',
                    style: TextStyle(color: AppTheme.textSecondary),
                  ),
                );
              }
              return ListView.separated(
                padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
                itemCount: laporan.length,
                separatorBuilder: (_, __) => const SizedBox(height: 12),
                itemBuilder: (context, i) {
                  final l = laporan[i];
                  return LaporanCard(
                    laporan: l,
                    onTap: () =>
                        Get.to(() => DetailLaporanPage(tiket: l.tiket)),
                  );
                },
              );
            }),
          ),
        ],
      ),
    );
  }
}
