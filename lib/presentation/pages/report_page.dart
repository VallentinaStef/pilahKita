import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
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
  bool hasPhoto = false;
  bool hasLocation = false;
  ReportLocation? selectedLocation;
  bool showValidationError = false;

  Future<void> openPickLocation() async {
    final result = await Navigator.push<ReportLocation>(
      context,
      MaterialPageRoute(builder: (context) => const PickLocationPage()),
    );
    if (result != null) {
      setState(() {
        selectedLocation = result;
        hasLocation = true;
      });
    }
  }

  void validateAndSubmit() {
    setState(() {
      showValidationError =
          !hasPhoto ||
          selectedType == null ||
          selectedSize == null ||
          !hasLocation;
    });
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
      backgroundColor: AppColors.mapGreen,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Laporkan sampah',
                style: Theme.of(context).textTheme.titleLarge,
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
                      // camera placeholder
                      GestureDetector(
                        onTap: () {
                          // TODO: buka halaman kamera
                        },
                        child: Container(
                          width: double.infinity,
                          height: 130,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(
                              color:
                                  !hasPhoto && showValidationError
                                      ? AppColors.red
                                      : AppColors.border.withValues(alpha: 0.7),
                              width: !hasPhoto && showValidationError ? 2 : 1,
                            ),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                hasPhoto
                                    ? Icons.check_circle_outline
                                    : Icons.camera_alt_outlined,
                                size: 48,
                                color: AppColors.darkGreen,
                              ),
                              const SizedBox(height: 8),
                              Text(
                                hasPhoto
                                    ? 'Foto siap digunakan'
                                    : 'Foto wajib diisi',
                                style: TextStyle(
                                  color:
                                      !hasPhoto && showValidationError
                                          ? AppColors.red
                                          : AppColors.textGrey,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Text(
                        'Jenis sampah',
                        style: TextStyle(
                          color:
                              selectedType == null && showValidationError
                                  ? AppColors.red
                                  : AppColors.textDark,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                  ? AppColors.red
                                  : AppColors.textDark,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
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
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16),
                            border:
                                !hasLocation && showValidationError
                                    ? Border.all(color: AppColors.red, width: 2)
                                    : null,
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
                                  ? AppColors.red
                                  : AppColors.textGrey,
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
        color: AppColors.pink,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          const Text(
            '!',
            style: TextStyle(color: AppColors.red, fontWeight: FontWeight.w800),
          ),
          const SizedBox(width: 8),
          Text(
            '$missingCount isian belum lengkap. Lengkapi lalu kirim lagi.',
            style: const TextStyle(
              color: AppColors.red,
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
