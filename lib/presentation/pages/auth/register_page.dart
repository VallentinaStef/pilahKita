import 'package:flutter/material.dart';
import '../../shell/home_shell.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final namaController = TextEditingController();
  final emailController = TextEditingController();
  final hpController = TextEditingController();
  final pwController = TextEditingController();

  bool obscurePw = true;

  @override
  void dispose() {
    namaController.dispose();
    emailController.dispose();
    hpController.dispose();
    pwController.dispose();
    super.dispose();
  }

  void daftar() {
    if (namaController.text.isEmpty ||
        emailController.text.isEmpty ||
        hpController.text.isEmpty ||
        pwController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Semua data wajib diisi'),
        ),
      );
      return;
    }

    // akun daftar otomatis jadi warga
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const HomeShell(
          role: RolePengguna.warga,
        ),
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
        title: const Text('Daftar sebagai warga'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(28),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 20),

            const Text(
              'Buat akun',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 8),

            const Text(
              'Daftar untuk menggunakan PilahKita.',
              style: TextStyle(
                color: Colors.black54,
              ),
            ),

            const SizedBox(height: 28),

            TextField(
              controller: namaController,
              decoration: const InputDecoration(
                labelText: 'Nama lengkap',
                prefixIcon: Icon(Icons.person_outline),
              ),
            ),

            const SizedBox(height: 18),

            TextField(
              controller: emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                labelText: 'Email',
                prefixIcon: Icon(Icons.email_outlined),
              ),
            ),

            const SizedBox(height: 18),

            TextField(
              controller: hpController,
              keyboardType: TextInputType.phone,
              decoration: const InputDecoration(
                labelText: 'Nomor HP',
                prefixIcon: Icon(Icons.phone_outlined),
              ),
            ),

            const SizedBox(height: 18),

            TextField(
              controller: pwController,
              obscureText: obscurePw,
              decoration: InputDecoration(
                labelText: 'Kata sandi',
                prefixIcon: const Icon(Icons.lock_outline),
                suffixIcon: IconButton(
                  icon: Icon(
                    obscurePw
                        ? Icons.visibility_off
                        : Icons.visibility,
                  ),
                  onPressed: () {
                    setState(() {
                      obscurePw = !obscurePw;
                    });
                  },
                ),
              ),
            ),

            const SizedBox(height: 28),

            SizedBox(
              height: 52,
              child: ElevatedButton(
                onPressed: daftar,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFB7F34A),
                  foregroundColor: const Color(0xFF104B37),
                ),
                child: const Text(
                  'Buat akun',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 16),

            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Sudah punya akun? Masuk'),
            ),
          ],
        ),
      ),
    );
  }
}