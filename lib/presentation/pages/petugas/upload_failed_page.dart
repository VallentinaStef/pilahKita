import 'package:flutter/material.dart';

import '../../theme/app_colors.dart';
import '../../widgets/petugas/primary_action_button.dart';

class UploadFailedPage extends StatelessWidget {
  final VoidCallback onRetry;
  final VoidCallback onBackToTasks;

  const UploadFailedPage({
    super.key,
    required this.onRetry,
    required this.onBackToTasks,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Unggah bukti')),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.cloud_off_outlined,
                  color: AppColors.red,
                  size: 78,
                ),
                const SizedBox(height: 18),
                const Text(
                  'Foto bukti belum terunggah',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: AppColors.textDark,
                    fontSize: 23,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  'Tugas belum ditandai selesai. Foto tetap tersimpan di layar pratinjau sampai proses unggah berhasil.',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: AppColors.textGrey, height: 1.5),
                ),
                const SizedBox(height: 18),
                Container(
                  padding: const EdgeInsets.all(13),
                  decoration: BoxDecoration(
                    color: AppColors.pink,
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: const Row(
                    children: [
                      Icon(Icons.error_outline, color: AppColors.red),
                      SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          'Simulasi: koneksi terputus saat mengunggah.',
                          style: TextStyle(color: AppColors.red, fontSize: 12),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 22),
                PrimaryActionButton(
                  text: 'Unggah lagi',
                  icon: Icons.cloud_upload_outlined,
                  onPressed: onRetry,
                ),
                const SizedBox(height: 10),
                OutlinedButton(
                  onPressed: onBackToTasks,
                  child: const Text('Kembali ke tugas'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}