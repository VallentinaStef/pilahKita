import 'package:flutter/material.dart';

class RiwayatAktivitasPage extends StatelessWidget {
  const RiwayatAktivitasPage({super.key});

  @override
  Widget build(BuildContext context) {
    final aktivitas = [
      {
        'judul': 'Login berhasil',
        'waktu': '05 Nov 2026 • 19:20',
        'icon': Icons.login,
      },
      {
        'judul': 'Profil diperbarui',
        'waktu': '05 Nov 2026 • 19:10',
        'icon': Icons.edit_outlined,
      },
      {
        'judul': 'Akun dibuat',
        'waktu': '01 Nov 2026 • 15:30',
        'icon': Icons.person_add_outlined,
      },
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFEAF4E4),
      appBar: AppBar(
        backgroundColor: const Color(0xFF104B37),
        foregroundColor: Colors.white,
        title: const Text('Riwayat Aktivitas'),
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(20),
        itemCount: aktivitas.length,
        separatorBuilder: (_, __) => const SizedBox(height: 12),
        itemBuilder: (context, index) {
          final data = aktivitas[index];

          return Card(
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: const Color(0xFFEAF4E4),
                child: Icon(
                  data['icon'] as IconData,
                  color: const Color(0xFF104B37),
                ),
              ),
              title: Text(
                data['judul'] as String,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Text(data['waktu'] as String),
            ),
          );
        },
      ),
    );
  }
}