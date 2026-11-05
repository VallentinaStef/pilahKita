import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../domain/entities/report_location.dart';
import '../themes/app_colors.dart';
import '../widgets/primary_button.dart';

class PickLocationPage extends StatelessWidget {
  const PickLocationPage({super.key});

  // data sementara
  final ReportLocation currentLocation = const ReportLocation(
    address: 'Telkom University',
    area: ' Jl. Telekomunikasi No.1',
    latitude: -6.8915,
    longitude: 107.6177,
  );

  @override
  Widget build(BuildContext context) {
    final sheetHeight = MediaQuery.of(context).size.height * 0.4;

    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'lib/assets/map-placeholder.png',
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(color: AppColors.background);
              },
            ),
          ),

          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Align(
                alignment: Alignment.topLeft,
                child: GestureDetector(
                  onTap: () {
                    Get.to((){});
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.accent,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Text(
                      'Pakai lokasi saya',
                      style: TextStyle(
                        color: AppColors.primary,
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),

          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              width: double.infinity,
              height: sheetHeight,
              padding: const EdgeInsets.all(24),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
              ),
              child: SafeArea(
                top: false,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      currentLocation.address,
                      style: const TextStyle(
                        color: AppColors.textPrimary,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '${currentLocation.area}. ${currentLocation.latitude}, ${currentLocation.longitude}',
                      style: const TextStyle(
                        color: AppColors.textSecondary,
                        fontSize: 12,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Geser peta untuk memindahkan titik.',
                      style: TextStyle(color: AppColors.textSecondary, fontSize: 12),
                    ),
                    const Spacer(),
                    AppButton(
                      text: 'Konfirmasi lokasi',
                      onPressed: () => Get.back(result: currentLocation),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
