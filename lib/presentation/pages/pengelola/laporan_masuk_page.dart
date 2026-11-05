import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/pengelola_controller.dart';
import '../../themes/app_colors.dart';
import '../../widgets/status_chip.dart';

class LaporanMasukPage extends StatelessWidget {
  LaporanMasukPage({super.key});

  final controller = Get.put(PengelolaController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        title: const Text(
          'Laporan Masuk',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              onChanged: controller.cariLaporan,
              decoration: InputDecoration(
                hintText: 'Cari nomor tiket atau alamat',
                prefixIcon: const Icon(Icons.search),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
            ),

            const SizedBox(height: 16),

            Expanded(
              child: Obx(() {
                final laporan = controller.laporanMasuk;

                if (laporan.isEmpty) {
                  return const Center(child: Text('Tidak ada laporan masuk'));
                }

                return ListView(
                  children: [
                    for (int i = 0; i < laporan.length; i++)
                      Card(
                        color: Colors.white,
                        margin: const EdgeInsets.only(bottom: 12),
                        child: ListTile(
                          contentPadding: const EdgeInsets.all(14),
                          title: Text(
                            laporan[i].tiket,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          subtitle: Padding(
                            padding: const EdgeInsets.only(top: 8),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(laporan[i].alamat),
                                const SizedBox(height: 6),
                                Text(laporan[i].ringkasan),
                                const SizedBox(height: 10),
                                StatusChip(status: laporan[i].status),
                              ],
                            ),
                          ),
                          trailing: const Icon(
                            Icons.arrow_forward_ios,
                            size: 16,
                          ),
                          onTap: () {
                            Get.snackbar(
                              'Laporan dipilih',
                              'Nomor tiket: ${laporan[i].tiket}',
                            );
                          },
                        ),
                      ),
                  ],
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
