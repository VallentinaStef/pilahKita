import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/pengelola_controller.dart';
import '../../themes/app_colors.dart';
import '../../widgets/status_chip.dart';
import '../../../domain/entities/laporan.dart';

class LaporanMasukPage extends StatelessWidget {
  LaporanMasukPage({super.key});

  final controller = Get.put(PengelolaController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        elevation: 0,
        title: const Text(
          'Laporan Masuk',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Pencarian laporan
            TextField(
              onChanged: controller.cariLaporan,
              decoration: InputDecoration(
                hintText: 'Cari nomor tiket atau alamat',
                hintStyle: const TextStyle(fontSize: 12),
                prefixIcon: const Icon(
                  Icons.search,
                  color: AppColors.textSecondary,
                ),
                filled: true,
                fillColor: AppColors.surface,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
            ),

            const SizedBox(height: 16),

            const Text(
              'Filter laporan',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
              ),
            ),

            const SizedBox(height: 10),

            // Filter status
            Obx(
              () => SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    _filterItem(
                      'Semua',
                      FilterLaporan.semua,
                      controller.daftarLaporan.length,
                    ),
                    _filterItem(
                      'Menunggu',
                      FilterLaporan.menunggu,
                      controller.jumlahStatus(StatusLaporan.menunggu),
                    ),
                    _filterItem(
                      'Diproses',
                      FilterLaporan.diproses,
                      controller.jumlahStatus(StatusLaporan.diproses),
                    ),
                    _filterItem(
                      'Selesai',
                      FilterLaporan.selesai,
                      controller.jumlahStatus(StatusLaporan.selesai),
                    ),
                    _filterItem(
                      'Ditolak',
                      FilterLaporan.ditolak,
                      controller.jumlahStatus(StatusLaporan.ditolak),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 16),

            // Judul daftar laporan
            Obx(
              () => Text(
                'Daftar laporan (${controller.laporanMasuk.length})',
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
              ),
            ),

            const SizedBox(height: 10),

            // Daftar laporan
            Expanded(
              child: Obx(() {
                final laporan = controller.laporanMasuk;

                if (laporan.isEmpty) {
                  return const Center(
                    child: Text(
                      'Tidak ada laporan ditemukan',
                      style: TextStyle(
                        color: AppColors.textSecondary,
                        fontSize: 13,
                      ),
                    ),
                  );
                }

                return ListView.builder(
                  itemCount: laporan.length,
                  itemBuilder: (context, index) {
                    final item = laporan[index];

                    return Card(
                      color: AppColors.surface,
                      elevation: 1,
                      margin: const EdgeInsets.only(bottom: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: ListTile(
                        contentPadding: const EdgeInsets.all(14),
                        title: Text(
                          item.tiket,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: AppColors.primary,
                          ),
                        ),
                        subtitle: Padding(
                          padding: const EdgeInsets.only(top: 8),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  const Icon(
                                    Icons.location_on_outlined,
                                    size: 15,
                                    color: AppColors.textSecondary,
                                  ),
                                  const SizedBox(width: 4),
                                  Expanded(
                                    child: Text(
                                      item.alamat,
                                      style: const TextStyle(fontSize: 12),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 7),
                              Text(
                                item.ringkasan,
                                style: const TextStyle(fontSize: 12),
                              ),
                              const SizedBox(height: 10),
                              StatusChip(status: item.status),
                            ],
                          ),
                        ),
                        trailing: const Icon(
                          Icons.arrow_forward_ios,
                          size: 16,
                          color: AppColors.textSecondary,
                        ),
                        onTap: () {
                          Get.snackbar(
                            'Laporan dipilih',
                            'Nomor tiket: ${item.tiket}',
                            snackPosition: SnackPosition.BOTTOM,
                          );
                        },
                      ),
                    );
                  },
                );
              }),
            ),
          ],
        ),
      ),
    );
  }

  // Tombol filter
  Widget _filterItem(String judul, FilterLaporan filter, int jumlah) {
    final aktif = controller.filterAktif.value == filter;

    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: ChoiceChip(
        label: Text('$judul ($jumlah)'),
        selected: aktif,
        onSelected: (_) {
          controller.ubahFilter(filter);
        },
        selectedColor: AppColors.primary,
        backgroundColor: AppColors.surface,
        labelStyle: TextStyle(
          color: aktif ? Colors.white : AppColors.textPrimary,
          fontSize: 11,
          fontWeight: FontWeight.w600,
        ),
        side: BorderSide.none,
      ),
    );
  }
}
