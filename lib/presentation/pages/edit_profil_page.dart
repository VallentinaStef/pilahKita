import 'package:flutter/material.dart';

class EditProfilPage extends StatefulWidget {
  const EditProfilPage({super.key});

  @override
  State<EditProfilPage> createState() => _EditProfilPageState();
}

class _EditProfilPageState extends State<EditProfilPage> {
  final namaController = TextEditingController(text: 'Nadhifah');
  final emailController =
      TextEditingController(text: 'warga@pilahkita.com');
  final hpController =
      TextEditingController(text: '081234567890');

  @override
  void dispose() {
    namaController.dispose();
    emailController.dispose();
    hpController.dispose();
    super.dispose();
  }

  void simpan() {
    if (namaController.text.isEmpty ||
        emailController.text.isEmpty ||
        hpController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Semua data wajib diisi'),
        ),
      );
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Profil berhasil diperbarui'),
      ),
    );

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEAF4E4),

      // appbar edit profil
      appBar: AppBar(
        backgroundColor: const Color(0xFF104B37),
        foregroundColor: Colors.white,
        title: const Text('Edit Profil'),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // foto profil
            Center(
              child: Stack(
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

                  Positioned(
                    right: 0,
                    bottom: 0,
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: const BoxDecoration(
                        color: Color(0xFF104B37),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.camera_alt_outlined,
                        size: 18,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 28),

            // input nama
            TextField(
              controller: namaController,
              decoration: const InputDecoration(
                labelText: 'Nama lengkap',
                prefixIcon: Icon(Icons.person_outline),
              ),
            ),

            const SizedBox(height: 18),

            // input email
            TextField(
              controller: emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                labelText: 'Email',
                prefixIcon: Icon(Icons.email_outlined),
              ),
            ),

            const SizedBox(height: 18),

            // input nomor hp
            TextField(
              controller: hpController,
              keyboardType: TextInputType.phone,
              decoration: const InputDecoration(
                labelText: 'Nomor HP',
                prefixIcon: Icon(Icons.phone_outlined),
              ),
            ),

            const SizedBox(height: 28),

            // tombol simpan
            SizedBox(
              height: 52,
              child: ElevatedButton(
                onPressed: simpan,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFB7F34A),
                  foregroundColor: const Color(0xFF104B37),
                ),
                child: const Text(
                  'Simpan Perubahan',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 12),

            // batal edit
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Batal'),
            ),
          ],
        ),
      ),
    );
  }
}