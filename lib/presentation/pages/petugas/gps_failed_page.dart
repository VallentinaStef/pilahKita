import 'package:flutter/material.dart';

import '../../theme/app_colors.dart';
import '../../widgets/petugas/primary_action_button.dart';

class GpsFailedPage extends StatelessWidget {
  const GpsFailedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Validasi lokasi')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.location_off,
                color: AppColors.red,
                size: 76,
              ),
              const SizedBox(height: 18),
              const Text(
                'Kamu terlalu jauh',
                style: TextStyle(
                  color: AppColors.textDark,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                '120 m dari titik laporan. Batas penyelesaian 50 m.',
                textAlign: TextAlign.center,
                style: TextStyle(color: AppColors.textGrey),
              ),
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: AppColors.pink,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: const Text(
                  'Jarak ini hanya contoh untuk menampilkan kondisi GPS gagal. Lokasi perangkat belum dibaca.',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: AppColors.red, fontSize: 12),
                ),
              ),
              const SizedBox(height: 24),
              PrimaryActionButton(
                text: 'Cek lokasi lagi',
                onPressed: () => Navigator.pop(context),
              ),
            ],
          ),
        ),
      ),
    );
  }
}