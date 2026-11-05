import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pilahkita/presentation/pages/camera_page.dart';
import '../themes/app_colors.dart';
import '../widgets/primary_button.dart';
import '../../domain/entities/report_location.dart';
import '../../domain/entities/waste_size.dart';
import '../../domain/entities/waste_type.dart';
import '../widgets/waste_size_option.dart';
import '../widgets/waste_type_option.dart';
import 'pick_location_page.dart';

class ReportPage extends StatefulWidget {
  const ReportPage({super.key});

  @override
  State<ReportPage> createState() => _ReportPageState();
}

class _ReportPageState extends State<ReportPage> {
  WasteType? selectedType;
  WasteSize? selectedSize;
  String? selectedPhotoPath;
  bool hasLocation = false;
  ReportLocation? selectedLocation;
  bool showValidationError = false;

  bool get hasPhoto => selectedPhotoPath != null;

  Future<void> openPickLocation() async {
    final result = await Get.to<ReportLocation>(
      () => const PickLocationPage(),
    );
    if (result != null) {
      setState(() {
        selectedLocation = result;
        hasLocation = true;
      });
    }
  }

  void validateAndSubmit() {
    final isValid =
        hasPhoto &&
        selectedType != null &&
        selectedSize != null &&
        hasLocation;

    if (isValid) {
      Get.back();
      return;
    }

    setState(() => showValidationError = true);
  }

  Color getTypeColor(WasteType type) {
    switch (type) {
      case WasteType.organik:
        return Colors.green;
      case WasteType.anorganik:
        return Colors.amber;
      case WasteType.campuran:
        return const Color.fromARGB(255, 43, 24, 17);
    }
  }

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
              Row(
                children: [
                  IconButton(
                    onPressed: () => Get.back(),
                    icon: const Icon(Icons.arrow_back),
                    color: AppColors.primary,
                  ),
                  const SizedBox(width: 6),
                  Text(
                    'Laporkan sampah',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ],
              ),
              const SizedBox(height: 16),
              if (showValidationError) ...[
                _ValidationAlert(
                  missingCount:
                      [
                        !hasPhoto,
                        selectedType == null,
                        selectedSize == null,
                        !hasLocation,
                      ].where((missing) => missing).length,
                ),
                const SizedBox(height: 12),
              ],
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GestureDetector(
                        onTap: _openCamera,
                        child: Container(
                          width: double.infinity,
                          height: 130,
                          decoration: BoxDecoration(
                            color: AppColors.surface,
                            border: Border.all(
                              color:
                                  !hasPhoto && showValidationError
                                      ? AppColors.danger
                                      : AppColors.primary.withValues(
                                        alpha: 0.24,
                                      ),
                              width: !hasPhoto && showValidationError ? 2 : 1.2,
                            ),
                            borderRadius: BorderRadius.circular(14),
                          ),
                          child:
                              selectedPhotoPath == null
                                  ? Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.camera_alt_outlined,
                                        size: 42,
                                        color:
                                            !hasPhoto && showValidationError
                                                ? AppColors.danger
                                                : AppColors.primary,
                                      ),
                                      const SizedBox(height: 8),
                                      Text(
                                        'Foto wajib diisi',
                                        style: TextStyle(
                                          color:
                                              !hasPhoto && showValidationError
                                                  ? AppColors.danger
                                                  : AppColors.textSecondary,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  )
                                  : ClipRRect(
                                    borderRadius: BorderRadius.circular(13),
                                    child: Stack(
                                      fit: StackFit.expand,
                                      children: [
                                        Image.asset(
                                          selectedPhotoPath!,
                                          fit: BoxFit.cover,
                                        ),
                                        const Align(
                                          alignment: Alignment.bottomLeft,
                                          child: Padding(
                                            padding: EdgeInsets.all(10),
                                            child: DecoratedBox(
                                              decoration: BoxDecoration(
                                                color: AppColors.success,
                                                borderRadius: BorderRadius.all(
                                                  Radius.circular(8),
                                                ),
                                              ),
                                              child: Padding(
                                                padding: EdgeInsets.symmetric(
                                                  horizontal: 8,
                                                  vertical: 5,
                                                ),
                                                child: Text(
                                                  'Foto dipilih',
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 11,
                                                    fontWeight: FontWeight.w700,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Text(
                        'Jenis sampah',
                        style: TextStyle(
                          color:
                              selectedType == null && showValidationError
                                  ? AppColors.danger
                                  : AppColors.textPrimary,
                          fontSize: 13,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 0.1,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children:
                            WasteType.values.map((type) {
                              return WasteTypeOption(
                                label: type.label,
                                iconColor: getTypeColor(type),
                                isSelected: selectedType == type,
                                hasError:
                                    selectedType == null && showValidationError,
                                onTap:
                                    () => setState(() => selectedType = type),
                              );
                            }).toList(),
                      ),
                      const SizedBox(height: 20),
                      Text(
                        'Seberapa banyak?',
                        style: TextStyle(
                          color:
                              selectedSize == null && showValidationError
                                  ? AppColors.danger
                                  : AppColors.textPrimary,
                          fontSize: 13,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 0.1,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        spacing: 8,
                        children:
                            WasteSize.values.map((size) {
                              return WasteSizeOption(
                                label: size.label,
                                isSelected: selectedSize == size,
                                hasError:
                                    selectedSize == null && showValidationError,
                                backgroundColor: switch (size) {
                                  WasteSize.kecil => AppColors.warning,
                                  WasteSize.sedang => AppColors.processing,
                                  WasteSize.besar => AppColors.danger,
                                },
                                onTap:
                                    () => setState(() => selectedSize = size),
                              );
                            }).toList(),
                      ),
                      const SizedBox(height: 20),
                      // placeholder lokasi
                      GestureDetector(
                        onTap: openPickLocation,
                        child: Container(
                          width: double.infinity,
                          height: 90,
                          decoration: BoxDecoration(
                            color: AppColors.surface,
                            borderRadius: BorderRadius.circular(14),
                            border:
                                !hasLocation && showValidationError
                                    ? Border.all(
                                      color: AppColors.danger,
                                      width: 2,
                                    )
                                    : Border.all(
                                      color: AppColors.primary.withValues(
                                        alpha: 0.24,
                                      ),
                                      width: 1.2,
                                    ),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(16),
                            child: Stack(
                              fit: StackFit.expand,
                              children: [
                                Image.asset(
                                  'lib/assets/map-placeholder.png',
                                  fit: BoxFit.cover,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        hasLocation
                            ? selectedLocation!.address
                            : showValidationError
                            ? 'Titik lokasi belum dipilih'
                            : 'Ketuk untuk pilih lokasi',
                        style: TextStyle(
                          fontSize: 12,
                          color:
                              !hasLocation && showValidationError
                                  ? AppColors.danger
                                  : AppColors.textSecondary,
                          fontWeight:
                              !hasLocation && showValidationError
                                  ? FontWeight.w600
                                  : FontWeight.normal,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 12),
              AppButton(text: 'Kirim laporan', onPressed: validateAndSubmit),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _openCamera() async {
    final imagePath = await Get.to<String>(() => const CameraPage());
    if (imagePath != null && mounted) {
      setState(() => selectedPhotoPath = imagePath);
    }
  }
}

class _ValidationAlert extends StatelessWidget {
  const _ValidationAlert({required this.missingCount});

  final int missingCount;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 9),
      decoration: BoxDecoration(
        color: AppColors.rejectBackground,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          const Text(
            '!',
            style: TextStyle(
              color: AppColors.danger,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(width: 8),
          Text(
            '$missingCount isian belum lengkap. Lengkapi lalu kirim lagi.',
            style: const TextStyle(
              color: AppColors.danger,
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
