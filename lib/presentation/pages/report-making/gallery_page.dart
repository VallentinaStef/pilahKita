import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../themes/app_colors.dart';
import '../../widgets/app_back_header.dart';
import '../../widgets/gallery_tile.dart';
import '../../widgets/primary_button.dart';

class GalleryPage extends StatefulWidget {
  const GalleryPage({super.key});

  @override
  State<GalleryPage> createState() => _GalleryPageState();
}

class _GalleryPageState extends State<GalleryPage> {
  static const _placeholderImage = 'lib/assets/sampah-numpuk.jpg';
  int? selectedIndex;

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
                title: 'Pilih dari galeri',
                onBack: () => Get.back(),
              ),
              const SizedBox(height: 24),
              Expanded(
                child: GridView.builder(
                  itemCount: 15,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    mainAxisSpacing: 6,
                    crossAxisSpacing: 6,
                  ),
                  itemBuilder: (context, index) {
                    return GalleryTile(
                      imagePath: _placeholderImage,
                      isSelected: selectedIndex == index,
                      onTap: () => setState(() => selectedIndex = index),
                    );
                  },
                ),
              ),
              const SizedBox(height: 12),
              Text(
                selectedIndex == null ? 'Belum ada foto dipilih' : '1 foto dipilih',
                style: const TextStyle(color: AppColors.textSecondary, fontSize: 12),
              ),
              const SizedBox(height: 12),
              AppButton(
                text: 'Pilih foto',
                onPressed: () {
                  if (selectedIndex != null) {
                    Get.back(result: _placeholderImage);
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
