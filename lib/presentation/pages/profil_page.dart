import 'package:flutter/material.dart';
import 'edit_profil_page.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEAF4E4),

      appBar: AppBar(
        backgroundColor: const Color(0xFF104B37),
        foregroundColor: Colors.white,
        title: const Text('Profil Saya'),
      ),

      body: Padding(
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

            const Text(
              'Nadhifah',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 8),

            const Text(
              'warga@pilahkita.com',
              style: TextStyle(
                color: Colors.black54,
              ),
            ),

            const SizedBox(height: 30),

            const Text(
              'Nomor HP: 081234567890',
              style: TextStyle(fontSize: 15),
            ),

            const SizedBox(height: 30),

            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton.icon(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const EditProfilPage(),
                    ),
                  );
                },
                icon: const Icon(Icons.edit_outlined),
                label: const Text('Edit Profil'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFB7F34A),
                  foregroundColor: const Color(0xFF104B37),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}