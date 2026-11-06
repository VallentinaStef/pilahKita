import 'package:flutter/material.dart';

import '../pages/pengelola/laporan_masuk_page.dart';
import '../pages/pengelola/monitoring_map_page.dart';
import '../pages/pengelola/dashboard_pengelola_page.dart';
import '../pages/pengelola/kelola_petugas_page.dart';
import '../pages/pengelola/profil_pengelola_page.dart';
import '../themes/app_colors.dart';

class PengelolaShell extends StatefulWidget {
  const PengelolaShell({super.key});

  @override
  State<PengelolaShell> createState() => _PengelolaShellState();
}

class _PengelolaShellState extends State<PengelolaShell> {
  int _index = 0;

  // semua halaman pengelola
  final List<Widget> _pages = [
    LaporanMasukPage(),
    const MonitoringMapPage(),
    const DashboardPengelolaPage(),
    const KelolaPetugasPage(),
    const ProfilPengelolaPage(),
  ];

  // icon navbar
  final List<IconData> _icons = [
    Icons.list_alt,
    Icons.location_on_outlined,
    Icons.bar_chart,
    Icons.people_outline,
    Icons.person_outline,
  ];

  // nama navbar
  final List<String> _labels = [
    'Laporan',
    'Peta',
    'Dashboard',
    'Petugas',
    'Profil',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_index],

      // navbar pengelola
      bottomNavigationBar: SafeArea(
        minimum: const EdgeInsets.only(bottom: 12),
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 12),
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: AppColors.primary,
            borderRadius: BorderRadius.circular(25),
          ),
          child: Row(
            children: [
              for (int i = 0; i < _labels.length; i++)
                Expanded(
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        _index = i;
                      });
                    },
                    borderRadius: BorderRadius.circular(12),
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      decoration: BoxDecoration(
                        color: _index == i
                            ? AppColors.accent
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            _icons[i],
                            color: _index == i
                                ? AppColors.primary
                                : Colors.white,
                            size: 21,
                          ),
                          const SizedBox(height: 3),
                          Text(
                            _labels[i],
                            style: TextStyle(
                              fontSize: 10,
                              color: _index == i
                                  ? AppColors.primary
                                  : Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}