import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../widgets/primary_button.dart';
import '../../domain/entities/waste_size.dart';
import '../../domain/entities/waste_type.dart';
import '../widgets/waste_size_option.dart';
import '../widgets/waste_type_option.dart';

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
  bool showValidationError = false;

  void validateAndSubmit() {
    setState(() {
      showValidationError = !hasPhoto || selectedType == null || !hasLocation;
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
              const Text(
                'Laporkan sampah',
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              if (showValidationError) ...[
                _ValidationAlert(
                  missingCount:
                      [
                        !hasPhoto,
                        selectedType == null,
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
                      const Text(
                        'Jenis sampah',
                        style: TextStyle(
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
                      const Text(
                        'Seberapa banyak?',
                        style: TextStyle(
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
                                onTap:
                                    () => setState(() => selectedSize = size),
                              );
                            }).toList(),
                      ),
                      const SizedBox(height: 20),
                      // placeholder lokasi
                      Container(
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
                        child: const Icon(
                          Icons.location_on,
                          color: Colors.deepOrange,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        hasLocation
                            ? 'Telkom University'
                            : showValidationError
                            ? 'Titik lokasi belum dipilih'
                            : 'Telkom University',
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
