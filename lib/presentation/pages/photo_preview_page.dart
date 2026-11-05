import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../themes/app_colors.dart';
import '../widgets/app_back_header.dart';
import '../widgets/primary_button.dart';

class PhotoPreviewPage extends StatelessWidget {
  const PhotoPreviewPage({
    super.key,
    required this.imagePath,
  });

  final String imagePath;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppBackHeader(
                title: 'Foto sampah',
                onBack: Get.back,
              ),
              const SizedBox(height: 24),

              AspectRatio(
                aspectRatio: 1,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(14),
                  child: Image.asset(
                    imagePath,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        color: AppColors.rejectBackground,
                        alignment: Alignment.center,
                        child: const Text('Foto tidak tersedia'),
                      );
                    },
                  ),
                ),
              ),
              const SizedBox(height: 12),
              const Text(
                'Pastikan tumpukan sampah terlihat jelas.',
                style: TextStyle(color: AppColors.textSecondary, fontSize: 12),
              ),
              const Spacer(),
              AppButton(
                text: 'Pakai foto',
                onPressed: () => Get.back(result: imagePath),
              ),
              const SizedBox(height: 12),
              AppButton(
                text: 'Ulangi foto',
                outlined: true,
                onPressed: Get.back,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
