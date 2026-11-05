import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../themes/app_colors.dart';
import '../../controllers/dashboard_controller.dart';
import '../../../domain/entities/laporan.dart';
import '../../../data/services/export_laporan_excel.dart';

class DashboardPengelolaPage extends StatelessWidget {
  const DashboardPengelolaPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<DashboardController>();

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Obx(
          () => SingleChildScrollView(
            child: Column(
              children: [
                // Header dashboard
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.fromLTRB(24, 22, 24, 20),
                  decoration: const BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(28),
                      bottomRight: Radius.circular(28),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Dashboard Pengelola',
                        style: TextStyle(color: Colors.white70, fontSize: 20),
                      ),
                      const SizedBox(height: 12),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Total laporan masuk',
                                style: TextStyle(
                                  color: Colors.white70,
                                  fontSize: 13,
                                ),
                              ),
                              const SizedBox(height: 3),
                              Text(
                                '${controller.totalLaporan}',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 36,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 14,
                              vertical: 8,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.accent,
                              borderRadius: BorderRadius.circular(24),
                            ),
                            child: Text(
                              '${controller.persentaseSelesai}% selesai',
                              style: const TextStyle(
                                color: AppColors.primary,
                                fontSize: 11,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                // Filter periode
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.surface,
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.calendar_month,
                          color: AppColors.primary,
                        ),
                        const SizedBox(width: 10),
                        const Text(
                          'Periode',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 12,
                          ),
                        ),
                        const Spacer(),
                        DropdownButton<FilterDashboard>(
                          value: controller.filterAktif.value,
                          underline: const SizedBox(),
                          isDense: true,
                          items: const [
                            DropdownMenuItem(
                              value: FilterDashboard.mingguIni,
                              child: Text('Minggu ini'),
                            ),
                            DropdownMenuItem(
                              value: FilterDashboard.bulanIni,
                              child: Text('Bulan ini'),
                            ),
                            DropdownMenuItem(
                              value: FilterDashboard.semua,
                              child: Text('Semua'),
                            ),
                            DropdownMenuItem(
                              value: FilterDashboard.tanggal,
                              child: Text('Rentang tanggal'),
                            ),
                          ],
                          onChanged: (value) {
                            if (value != null) {
                              controller.ubahFilter(value);
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                ),

                // Pilih tanggal
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 10, 16, 0),
                  child: SizedBox(
                    width: double.infinity,
                    child: OutlinedButton.icon(
                      onPressed: () async {
                        final tanggal = await showDateRangePicker(
                          context: context,
                          firstDate: DateTime(2020),
                          lastDate: DateTime.now(),
                          builder: (context, child) {
                            return Theme(
                              data: Theme.of(context).copyWith(
                                colorScheme: const ColorScheme.light(
                                  primary: AppColors.primary,
                                ),
                              ),
                              child: child!,
                            );
                          },
                        );

                        if (tanggal != null) {
                          controller.pilihTanggal(tanggal.start, tanggal.end);
                        }
                      },
                      icon: const Icon(Icons.date_range),
                      label: const Text('Pilih rentang tanggal'),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: AppColors.primary,
                      ),
                    ),
                  ),
                ),

                // Diagram jenis sampah
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: AppColors.surface,
                      borderRadius: BorderRadius.circular(18),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Jenis sampah',
                          style: TextStyle(
                            color: AppColors.textPrimary,
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Row(
                          children: [
                            SizedBox(
                              width: 110,
                              height: 110,
                              child: CustomPaint(
                                painter: DiagramSampah(
                                  organik: controller.persentaseJenis(
                                    JenisSampah.organik,
                                  ),
                                  anorganik: controller.persentaseJenis(
                                    JenisSampah.anorganik,
                                  ),
                                  campuran: controller.persentaseJenis(
                                    JenisSampah.campuran,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 15),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  _Legenda(
                                    warna: AppColors.success,
                                    nama: 'Organik',
                                    jumlah: controller.jumlahJenis(
                                      JenisSampah.organik,
                                    ),
                                    persen: controller.persentaseJenis(
                                      JenisSampah.organik,
                                    ),
                                  ),
                                  _Legenda(
                                    warna: AppColors.warning,
                                    nama: 'Anorganik',
                                    jumlah: controller.jumlahJenis(
                                      JenisSampah.anorganik,
                                    ),
                                    persen: controller.persentaseJenis(
                                      JenisSampah.anorganik,
                                    ),
                                  ),
                                  _Legenda(
                                    warna: AppColors.processing,
                                    nama: 'Campuran',
                                    jumlah: controller.jumlahJenis(
                                      JenisSampah.campuran,
                                    ),
                                    persen: controller.persentaseJenis(
                                      JenisSampah.campuran,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        if (controller.totalLaporan == 0)
                          const Center(
                            child: Text(
                              'Belum ada data laporan',
                              style: TextStyle(
                                color: AppColors.textSecondary,
                                fontSize: 11,
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ),

                // Grafik laporan selesai
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: AppColors.surface,
                      borderRadius: BorderRadius.circular(18),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Selesai per minggu',
                          style: TextStyle(
                            color: AppColors.textPrimary,
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                        ),
                        const SizedBox(height: 15),
                        SizedBox(
                          height: 120,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              for (int i = 4; i >= 0; i--)
                                Expanded(
                                  child: _GrafikMingguan(
                                    jumlah: controller.laporanSelesaiPerMinggu(
                                      5 - i,
                                    ),
                                    tertinggi:
                                        controller
                                            .jumlahSelesaiTerbanyakMingguan,
                                    label: 'M-${4 - i}',
                                  ),
                                ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 8),
                        const Center(
                          child: Text(
                            '5 minggu terakhir',
                            style: TextStyle(
                              color: AppColors.textSecondary,
                              fontSize: 10,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                // Tombol ekspor
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
                  child: SizedBox(
                    width: double.infinity,
                    height: 46,
                    child: OutlinedButton.icon(
                      onPressed: () async {
                        final periode = switch (controller.filterAktif.value) {
                          FilterDashboard.mingguIni => 'Minggu ini',
                          FilterDashboard.bulanIni => 'Bulan ini',
                          FilterDashboard.semua => 'Semua laporan',
                          FilterDashboard.tanggal =>
                            'Rentang ${controller.tanggalMulai.value?.day ?? '-'}'
                                '/${controller.tanggalMulai.value?.month ?? '-'}'
                                '/${controller.tanggalMulai.value?.year ?? '-'}'
                                ' - '
                                '${controller.tanggalAkhir.value?.day ?? '-'}'
                                '/${controller.tanggalAkhir.value?.month ?? '-'}'
                                '/${controller.tanggalAkhir.value?.year ?? '-'}',
                        };

                        try {
                          await ExportLaporanExcel.export(
                            laporan: controller.laporanTerfilter,
                            periode: periode,
                          );

                          Get.snackbar(
                            'Berhasil',
                            'File Excel berhasil dibuat.',
                            snackPosition: SnackPosition.BOTTOM,
                          );
                        } catch (e) {
                          Get.snackbar(
                            'Ekspor gagal',
                            e.toString(),
                            snackPosition: SnackPosition.BOTTOM,
                          );
                        }
                      },
                      icon: const Icon(Icons.file_download_outlined),
                      label: const Text(
                        'Ekspor Excel (.xlsx)',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      style: OutlinedButton.styleFrom(
                        backgroundColor: AppColors.surface,
                        foregroundColor: AppColors.primary,
                        side: const BorderSide(color: AppColors.primary),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
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
    );
  }
}

// Keterangan warna diagram
class _Legenda extends StatelessWidget {
  final Color warna;
  final String nama;
  final int jumlah;
  final double persen;

  const _Legenda({
    required this.warna,
    required this.nama,
    required this.jumlah,
    required this.persen,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 9),
      child: Row(
        children: [
          Container(
            width: 9,
            height: 9,
            decoration: BoxDecoration(color: warna, shape: BoxShape.circle),
          ),
          const SizedBox(width: 7),
          Expanded(child: Text(nama, style: const TextStyle(fontSize: 11))),
          Text(
            '$jumlah (${(persen * 100).round()}%)',
            style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }
}

class _GrafikMingguan extends StatelessWidget {
  final int jumlah;
  final int tertinggi;
  final String label;

  const _GrafikMingguan({
    required this.jumlah,
    required this.tertinggi,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    double tinggi = tertinggi == 0 ? 4 : (jumlah / tertinggi) * 75;

    if (jumlah > 0 && tinggi < 8) {
      tinggi = 8;
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Text('$jumlah', style: const TextStyle(fontSize: 10)),
        const SizedBox(height: 4),
        Container(
          height: tinggi,
          width: 22,
          decoration: BoxDecoration(
            color: jumlah > 0 ? AppColors.success : AppColors.accent,
            borderRadius: BorderRadius.circular(5),
          ),
        ),
        const SizedBox(height: 5),
        Text(
          label,
          style: const TextStyle(fontSize: 9, color: AppColors.textSecondary),
        ),
      ],
    );
  }
}

class DiagramSampah extends CustomPainter {
  final double organik;
  final double anorganik;
  final double campuran;

  DiagramSampah({
    required this.organik,
    required this.anorganik,
    required this.campuran,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint =
        Paint()
          ..style = PaintingStyle.stroke
          ..strokeWidth = 13
          ..strokeCap = StrokeCap.butt;

    final rect = Rect.fromCircle(
      center: Offset(size.width / 2, size.height / 2),
      radius: 36,
    );

    if (organik + anorganik + campuran == 0) {
      paint.color = AppColors.border;
      canvas.drawCircle(rect.center, 36, paint);
      return;
    }

    double awal = -1.5708;

    paint.color = AppColors.success;
    canvas.drawArc(rect, awal, organik * 6.28318, false, paint);

    awal += organik * 6.28318;

    paint.color = AppColors.warning;
    canvas.drawArc(rect, awal, anorganik * 6.28318, false, paint);

    awal += anorganik * 6.28318;

    paint.color = AppColors.processing;
    canvas.drawArc(rect, awal, campuran * 6.28318, false, paint);
  }

  @override
  bool shouldRepaint(covariant DiagramSampah oldDelegate) {
    return organik != oldDelegate.organik ||
        anorganik != oldDelegate.anorganik ||
        campuran != oldDelegate.campuran;
  }
}
