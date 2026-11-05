import 'package:flutter/material.dart';
import '../../../data/dummy_data.dart';
import '../../../domain/entities/laporan.dart';
import '../../themes/app_colors.dart';
import '../../widgets/map_filter_chip.dart';
import '../../widgets/report_summary_card.dart';

class MonitoringMapPage extends StatefulWidget {
  const MonitoringMapPage({super.key});

  @override
  State<MonitoringMapPage> createState() => _MonitoringMapPageState();
}

class _MonitoringMapPageState extends State<MonitoringMapPage> {
  int selectedIndex = 3;

  final List<_MapPin> pins = [
    _MapPin(alignment: Alignment(-0.53, -0.7), report: DummyData.laporan[0]),
    _MapPin(alignment: Alignment(0.28, -0.76), report: DummyData.laporan[1]),
    _MapPin(alignment: Alignment(0.6, -0.44), report: DummyData.laporan[2]),
    _MapPin(alignment: Alignment(-0.2, -0.34), report: DummyData.laporan[3]),
    _MapPin(alignment: Alignment(0.38, -0.16), report: DummyData.laporan[4]),
  ];

  Color getStatusColor(StatusLaporan status) {
    switch (status) {
      case StatusLaporan.menunggu:
        return Colors.orange;
      case StatusLaporan.diproses:
        return Colors.blue;
      case StatusLaporan.selesai:
        return Colors.green;
      case StatusLaporan.ditolak:
        return Colors.red;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // gambar peta
          Positioned.fill(
            child: Image.asset(
              'lib/assets/map-placeholder.png',
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(color: AppColors.background);
              },
            ),
          ),

          // pin laporan
          for (int i = 0; i < pins.length; i++)
            Align(
              alignment: pins[i].alignment,
              child: GestureDetector(
                onTap: () => setState(() => selectedIndex = i),
                child: Icon(
                  Icons.location_on,
                  size: selectedIndex == i ? 44 : 34,
                  color: getStatusColor(pins[i].report.status),
                ),
              ),
            ),

          // filter di atas peta
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                spacing: 8,
                children: [
                  MapFilterChip(
                    label: 'Semua status',
                    isActive: true,
                    onTap: () {},
                  ),
                  MapFilterChip(label: 'Kategori', onTap: () {}),
                  MapFilterChip(label: 'Minggu ini', onTap: () {}),
                ],
              ),
            ),
          ),

          // kartu laporan di bawah
          Positioned(
            left: 16,
            right: 16,
            bottom: 16,
            child: SafeArea(
              top: false,
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxHeight: 112),
                child: ReportSummaryCard(report: pins[selectedIndex].report),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// pasangan posisi pin di peta dan data laporannya
class _MapPin {
  final Alignment alignment;
  final Laporan report;

  _MapPin({required this.alignment, required this.report});
}
