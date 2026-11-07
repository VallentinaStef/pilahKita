import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../themes/app_colors.dart';
import '../auth/login_page.dart';

class ProfilPengelolaPage extends StatefulWidget {
  const ProfilPengelolaPage({super.key});

  @override
  State<ProfilPengelolaPage> createState() => _ProfilPengelolaPageState();
}

class _ProfilPengelolaPageState extends State<ProfilPengelolaPage> {
  // data profil pengelola
  String nama = 'Pengelola PilahKita';
  String email = 'pengelola@pilahkita.com';
  String hp = '081234567890';

  // ini buat buka edit profil
  Future<void> bukaEditProfil() async {
    final hasil = await showDialog<Map<String, String>>(
      context: context,
      builder: (context) {
        final namaController = TextEditingController(text: nama);
        final emailController = TextEditingController(text: email);
        final hpController = TextEditingController(text: hp);

        return AlertDialog(
          title: const Text('Edit Profil'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: namaController,
                  decoration: const InputDecoration(
                    labelText: 'Nama',
                  ),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: emailController,
                  decoration: const InputDecoration(
                    labelText: 'Email',
                  ),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: hpController,
                  decoration: const InputDecoration(
                    labelText: 'Nomor HP',
                  ),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Batal'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(
                  context,
                  {
                    'nama': namaController.text,
                    'email': emailController.text,
                    'hp': hpController.text,
                  },
                );
              },
              child: const Text('Simpan'),
            ),
          ],
        );
      },
    );

    if (hasil != null) {
      setState(() {
        nama = hasil['nama'] ?? nama;
        email = hasil['email'] ?? email;
        hp = hasil['hp'] ?? hp;
      });
    }
  }

  // ini popup buat nanya dulu sebelum logout
  Future<void> konfirmasiLogout() async {
    final konfirmasi = await Get.dialog<bool>(
      AlertDialog(
        title: const Text('Keluar dari akun?'),
        content: const Text(
          'Apa kamu yakin ingin keluar dari akun ini?',
        ),
        actions: [
          TextButton(
            onPressed: () {
              Get.back(result: false);
            },
            child: const Text('Batal'),
          ),
          TextButton(
            onPressed: () {
              Get.back(result: true);
            },
            child: const Text('Keluar'),
          ),
        ],
      ),
    );

    if (konfirmasi == true && mounted) {
      logout();
    }
  }

  // logout-nya sama konsepnya kayak punya teman
  void logout() {
    Get.offAll(
      () => const LoginPage(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEAF4E4),

      appBar: AppBar(
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        title: const Text('Profil Pengelola'),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            // foto profil
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

            // nama pengelola
            Text(
              nama,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 6),

            // email
            Text(
              email,
              style: const TextStyle(
                color: Colors.black54,
              ),
            ),

            const SizedBox(height: 28),

            // info nama
            _itemProfil(
              Icons.person_outline,
              'Nama',
              nama,
            ),

            // info email
            _itemProfil(
              Icons.email_outlined,
              'Email',
              email,
            ),

            // info nomor HP
            _itemProfil(
              Icons.phone_outlined,
              'Nomor HP',
              hp,
            ),

            const SizedBox(height: 24),

            // tombol edit profil
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

            // tombol logout
            SizedBox(
              width: double.infinity,
              height: 50,
              child: OutlinedButton.icon(
                onPressed: konfirmasiLogout,
                icon: const Icon(Icons.logout_outlined),
                label: const Text('Keluar'),
                style: OutlinedButton.styleFrom(
                  foregroundColor: const Color(0xFF104B37),
                  side: const BorderSide(
                    color: Color(0xFF104B37),
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // biar bagian data profilnya nggak nulis Container berulang-ulang
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