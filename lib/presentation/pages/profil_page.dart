import 'package:flutter/material.dart';
import 'edit_profil_page.dart';
import 'riwayat_aktivitas_page.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String nama = 'Nadhifah';
  String email = 'warga@pilahkita.com';
  String hp = '081234567890';

  Future<void> bukaEditProfil() async {
    final hasil = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditProfilPage(
          nama: nama,
          email: email,
          hp: hp,
        ),
      ),
    );

    if (hasil != null) {
      setState(() {
        nama = hasil['nama'];
        email = hasil['email'];
        hp = hasil['hp'];
      });
    }
  }

  void bukaRiwayatAktivitas() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const RiwayatAktivitasPage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEAF4E4),
      appBar: AppBar(
        backgroundColor: const Color(0xFF104B37),
        foregroundColor: Colors.white,
        title: const Text('Profil Saya'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            const CircleAvatar(
              radius: 55,
              backgroundColor: Color(0xFFB7F34A),
              child: Icon(
                Icons.person,
                size: 60,
                color: Color(0xFF104B37),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              nama,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              email,
              style: const TextStyle(
                color: Colors.black54,
              ),
            ),
            const SizedBox(height: 28),
            _itemProfil(
              Icons.person_outline,
              'Nama',
              nama,
            ),
            _itemProfil(
              Icons.email_outlined,
              'Email',
              email,
            ),
            _itemProfil(
              Icons.phone_outlined,
              'Nomor HP',
              hp,
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton.icon(
                onPressed: bukaEditProfil,
                icon: const Icon(Icons.edit_outlined),
                label: const Text('Edit Profil'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFB7F34A),
                  foregroundColor: const Color(0xFF104B37),
                ),
              ),
            ),
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: OutlinedButton.icon(
                onPressed: bukaRiwayatAktivitas,
                icon: const Icon(Icons.history),
                label: const Text('Riwayat Aktivitas'),
                style: OutlinedButton.styleFrom(
                  foregroundColor: const Color(0xFF104B37),
                  side: const BorderSide(
                    color: Color(0xFF104B37),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _itemProfil(
    IconData icon,
    String label,
    String value,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Icon(
            icon,
            color: const Color(0xFF104B37),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.black54,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}