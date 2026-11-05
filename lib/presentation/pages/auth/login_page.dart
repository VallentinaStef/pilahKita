import 'package:flutter/material.dart';
import '../../shell/home_shell.dart';
import 'register_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // buat nyimpen isi input email dan pw
  final emailController = TextEditingController();
  final pwController = TextEditingController();

  // buat show/hide pw
  bool obscurePw = true;

  final darkGreen = const Color(0xFF104B37);
  final lightGreen = const Color(0xFFEAF4E4);
  final limeGreen = const Color(0xFFB7F34A);

  @override
  void dispose() {
    emailController.dispose();
    pwController.dispose();
    super.dispose();
  }

  // cek input sebelum masuk ke beranda
  void login() {
    if (emailController.text.isEmpty ||
        pwController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Email dan password wajib diisi'),
        ),
      );
      return;
    }

    // kalau berhasil, langsung ke beranda
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const HomeShell(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: lightGreen,
      body: SingleChildScrollView(
        child: Column(
          children: [
            // bagian atas login
            Container(
              height: 300,
              width: double.infinity,
              decoration: BoxDecoration(
                color: darkGreen,
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(115),
                  bottomRight: Radius.circular(115),
                ),
              ),
              child: SafeArea(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.delete_outline,
                      color: Colors.white,
                      size: 55,
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'PilahKita',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 6),
                    const Text(
                      'Kelola sampah, jaga lingkungan.',
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // bagian form login
            Padding(
              padding: const EdgeInsets.all(28),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Text(
                    'Masuk',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Masuk untuk melanjutkan ke PilahKita.',
                    style: TextStyle(
                      color: Colors.black54,
                    ),
                  ),
                  const SizedBox(height: 28),

                  // input email
                  TextField(
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                      labelText: 'Email',
                      prefixIcon: Icon(Icons.email_outlined),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // input pw
                  TextField(
                    controller: pwController,
                    obscureText: obscurePw,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      prefixIcon: const Icon(Icons.lock_outline),
                      suffixIcon: IconButton(
                        icon: Icon(
                          obscurePw
                              ? Icons.visibility_off
                              : Icons.visibility,
                        ),
                        onPressed: () {
                          // ubah pw jadi kelihatan/sembunyi
                          setState(() {
                            obscurePw = !obscurePw;
                          });
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: 28),

                  // tombol masuk
                  SizedBox(
                    height: 52,
                    child: ElevatedButton(
                      onPressed: login,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: limeGreen,
                        foregroundColor: darkGreen,
                      ),
                      child: const Text(
                        'Masuk',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // pindah ke halaman daftar
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const RegisterPage(),
                        ),
                      );
                    },
                    child: const Text('Daftar sebagai warga'),
                  ),
                  const SizedBox(height: 8),

                  // info akun petugas/pengelola
                  const Text(
                    'Petugas dan Pengelola masuk dengan akun dari Pengelola.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.black54,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}