import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pilahkita/presentation/pages/report-making/gallery_page.dart';
import 'package:pilahkita/presentation/pages/report-making/photo_preview_page.dart';
import '../../themes/app_colors.dart';
import '../../widgets/scan_corner.dart';

class CameraPage extends StatefulWidget {
  const CameraPage({super.key});

  @override
  State<CameraPage> createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  static const _placeholderImage = 'lib/assets/sampah-numpuk.jpg';
  bool isFlashOn = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              _placeholderImage,
              fit: BoxFit.cover,
            ),
          ),
          Positioned.fill(
            child: ColoredBox(
              color: Colors.black.withValues(alpha: 0.08),
            ),
          ),
          Column(
            children: [
              // area kamera
              Expanded(
                child: SafeArea(
                  bottom: false,
                  child: Stack(
                    children: [
                  // tombol tutup
                  Positioned(
                    top: 16,
                    left: 16,
                    child: GestureDetector(
                      onTap: Get.back,
                      child: Container(
                        width: 44,
                        height: 44,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.black.withValues(alpha: 0.35),
                        ),
                        child: const Icon(Icons.close, color: Colors.white),
                      ),
                    ),
                  ),

                  // dekorasi bingkai kamera
                  Center(
                    child: SizedBox(
                      width: 250,
                      height: 320,
                      child: Stack(
                        children: [
                          const Align(
                            alignment: Alignment.topLeft,
                            child: ScanCorner(corner: Alignment.topLeft),
                          ),
                          const Align(
                            alignment: Alignment.topRight,
                            child: ScanCorner(corner: Alignment.topRight),
                          ),
                          const Align(
                            alignment: Alignment.bottomLeft,
                            child: ScanCorner(corner: Alignment.bottomLeft),
                          ),
                          const Align(
                            alignment: Alignment.bottomRight,
                            child: ScanCorner(corner: Alignment.bottomRight),
                          ),
                        ],
                      ),
                    ),
                  ),
                    ],
                  ),
                ),
              ),

              // bar bawah
              Container(
                width: double.infinity,
                color: Colors.black.withValues(alpha: 0.7),
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 20,
                ),
                child: SafeArea(
                  top: false,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                  // galeri
                  GestureDetector(
                    onTap: _openGallery,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          width: 48,
                          height: 48,
                          decoration: BoxDecoration(
                            color: AppColors.border,
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        const SizedBox(height: 4),
                        const Text(
                          'Galeri',
                          style: TextStyle(color: Colors.white, fontSize: 10),
                        ),
                      ],
                    ),
                  ),

                  // cekrek
                  GestureDetector(
                    onTap: () {
                      _openPreview();
                    },
                    child: Container(
                      width: 76,
                      height: 76,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.primary,
                        border: Border.all(color: AppColors.border, width: 4),
                      ),
                    ),
                  ),

                  // flash
                  GestureDetector(
                    onTap: () => setState(() => isFlashOn = !isFlashOn),
                    child: SizedBox(
                      width: 48,
                      child: Text(
                        isFlashOn ? 'Flash\nnyala' : 'Flash\nmati',
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Future<void> _openPreview() async {
    final imagePath = await Get.to<String>(
      () => const PhotoPreviewPage(imagePath: _placeholderImage),
    );
    if (imagePath != null && mounted) {
      Get.back(result: imagePath);
    }
  }

  Future<void> _openGallery() async {
    final imagePath = await Get.to<String>(() => const GalleryPage());
    if (imagePath != null && mounted) {
      Get.back(result: imagePath);
    }
  }
}
