import 'package:flutter/material.dart';

import '../pages/pengelola/dashboard_pengelola_page.dart';
import '../pages/pengelola/laporan_masuk_page.dart';
import '../pages/pengelola/kelola_petugas_page.dart';
import '../pages/profil_page.dart';
import '../pages/pengelola/monitoring_map_page.dart';

class PengelolaShell extends StatefulWidget {
  const PengelolaShell({super.key});

  @override
  State<PengelolaShell> createState() => _PengelolaShellState();
}

class _PengelolaShellState extends State<PengelolaShell> {
  int index = 0;

  final List<Widget> _pages = [
    LaporanMasukPage(),
    const MonitoringMapPage(),
    const DashboardPengelolaPage(),
    const Center(child: Text('Kelola Petugas')),
  ];

  final List<IconData> _icons = [
    Icons.list_alt,
    Icons.location_on_outlined,
    Icons.bar_chart,
    Icons.people_outline,
  ];

  final List<String> _labels = ['Laporan', 'Peta', 'Dashboard', 'Petugas'];

  @override
  Widget build(BuildContext context) {
    final pages = [
      const DashboardPengelolaPage(),
      LaporanMasukPage(),
      const KelolaPetugasPage(),
      const ProfilePage(),
    ];

    return Scaffold(
      body: pages[index],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: index,
        onTap: (value) {
          setState(() {
            index = value;
          });
        },
        type: BottomNavigationBarType.fixed,
        selectedItemColor: const Color(0xFF104B37),
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard_outlined),
            label: 'Dashboard',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.assignment_outlined),
            label: 'Laporan',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people_outline),
            label: 'Petugas',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            label: 'Profil',
          ),
        ],
      ),
    );
  }
}