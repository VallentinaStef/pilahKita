import 'package:flutter/material.dart';

import '../widgets/bottom_nav_scaffold.dart';
import '../pages/beranda_page.dart';
import '../pages/notifikasi_page.dart';
import '../pages/profil_page.dart';
import '../pages/pengelola/kelola_petugas_page.dart';

enum RolePengguna { warga, petugas, pengelola }

class HomeShell extends StatefulWidget {
  final RolePengguna role;

  const HomeShell({super.key, required this.role});

  @override
  State<HomeShell> createState() => _HomeShellState();
}

class _HomeShellState extends State<HomeShell> {
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    return BottomNavScaffold(
      currentIndex: _index,
      onTap: (i) {
        setState(() {
          _index = i;
        });
      },
      child: _buildPage(),
    );
  }

  Widget _buildPage() {
    if (widget.role == RolePengguna.warga) {
      return IndexedStack(
        index: _index,
        children: const [
          BerandaPage(),
          Center(child: Text('Riwayat')),
          NotifikasiPage(),
          ProfilePage(),
        ],
      );
    }

    if (widget.role == RolePengguna.petugas) {
      return IndexedStack(
        index: _index,
        children: const [
          PetugasPage(),
          Center(child: Text('Tugas')),
          NotifikasiPage(),
          ProfilePage(),
        ],
      );
    }

    return IndexedStack(
      index: _index,
      children: const [
        PengelolaPage(),
        Center(child: Text('Aktivitas')),
        NotifikasiPage(),
        ProfilePage(),
      ],
    );
  }
}

class PetugasPage extends StatelessWidget {
  const PetugasPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEAF4E4),
      appBar: AppBar(
        backgroundColor: const Color(0xFF104B37),
        foregroundColor: Colors.white,
        title: const Text('Beranda Petugas'),
      ),
      body: const Padding(
        padding: EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Halo, Petugas 👋',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              'Kelola laporan dan tugas pengangkutan sampah.',
              style: TextStyle(color: Colors.black54),
            ),
            SizedBox(height: 24),
            Card(
              child: ListTile(
                leading: Icon(Icons.assignment_outlined),
                title: Text('Laporan masuk'),
                subtitle: Text('Lihat laporan yang perlu ditangani'),
              ),
            ),
            Card(
              child: ListTile(
                leading: Icon(Icons.local_shipping_outlined),
                title: Text('Tugas hari ini'),
                subtitle: Text('0 tugas selesai'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PengelolaPage extends StatelessWidget {
  const PengelolaPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEAF4E4),
      appBar: AppBar(
        backgroundColor: const Color(0xFF104B37),
        foregroundColor: Colors.white,
        title: const Text('Dashboard Pengelola'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Halo, Pengelola 👋',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              'Kelola sistem dan petugas PilahKita.',
              style: TextStyle(color: Colors.black54),
            ),
            const SizedBox(height: 24),
            Card(
              child: ListTile(
                leading: const Icon(Icons.people_outline),
                title: const Text('Kelola petugas'),
                subtitle: const Text('Tambah, ubah, atau nonaktifkan petugas'),
                trailing: const Icon(Icons.chevron_right),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const KelolaPetugasPage(),
                    ),
                  );
                },
              ),
            ),
            const Card(
              child: ListTile(
                leading: Icon(Icons.history),
                title: Text('Aktivitas'),
                subtitle: Text('Lihat aktivitas sistem'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
