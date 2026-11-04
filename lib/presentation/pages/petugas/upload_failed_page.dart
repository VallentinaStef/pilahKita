import 'package:flutter/material.dart';

import '../../theme/app_colors.dart';
import '../../widgets/petugas/primary_action_button.dart';

class UploadFailedPage extends StatelessWidget {
  const UploadFailedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
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
                  'Tugas belum ditandai selesai. Foto tetap berada di halaman ini sampai dicoba kembali.',
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
                  text: 'Coba lagi',
                  onPressed: () => Navigator.pop(context),
                ),
                const SizedBox(height: 10),
                OutlinedButton(
                  onPressed: () {
                    Navigator.popUntil(context, (route) => route.isFirst);
                  },
                  child: const Text('Kembali ke daftar tugas'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}