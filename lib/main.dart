import 'package:flutter/material.dart';

void main() {
  runApp(const PilahKitaApp());
}

const Color darkGreen = Color(0xFF104B37);
const Color lightGreen = Color(0xFFEAF4E4);
const Color limeGreen = Color(0xFFB7F34A);

class PilahKitaApp extends StatelessWidget {
  const PilahKitaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'PilahKita',
      theme: ThemeData(
        scaffoldBackgroundColor: lightGreen,
        fontFamily: 'Roboto',
        colorScheme: ColorScheme.fromSeed(
          seedColor: darkGreen,
        ),
      ),
      home: const LoginPage(),
    );
  }
}

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // nampung input email & password
  final TextEditingController emailController =
      TextEditingController();

  final TextEditingController passwordController =
      TextEditingController();

  // hidden pw
  bool obscurePassword = true;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: SingleChildScrollView(
          child: Column(
            children: [
              // header PilahKita
              Container(
                width: double.infinity,
                height: 300,
                decoration: const BoxDecoration(
                  color: darkGreen,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(115),
                    bottomRight: Radius.circular(115),
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        const Icon(
                          Icons.delete_outline_rounded,
                          size: 95,
                          color: Color(0xFF36A36A),
                        ),
                        Positioned(
                          top: 4,
                          right: 12,
                          child: Transform.rotate(
                            angle: -0.3,
                            child: const Icon(
                              Icons.eco,
                              color: limeGreen,
                              size: 25,
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 8),

                    const Text(
                      'PilahKita',
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),

                    const SizedBox(height: 12),

                    const Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 25,
                      ),
                      child: Text(
                        'Lihat sampah liar? Foto, kirim, pantau sampai bersih.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 13,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              Padding(
                padding: const EdgeInsets.fromLTRB(
                  25,
                  35,
                  25,
                  30,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Email',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: darkGreen,
                        fontSize: 14,
                      ),
                    ),

                    TextField(
                      controller: emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: const InputDecoration(
                        hintText: 'Masukkan email',
                        hintStyle: TextStyle(
                          color: Colors.black45,
                          fontSize: 14,
                        ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: darkGreen,
                          ),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: darkGreen,
                            width: 2,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 22),

                    const Text(
                      'Kata sandi',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: darkGreen,
                        fontSize: 14,
                      ),
                    ),

                    TextField(
                      controller: passwordController,
                      obscureText: obscurePassword,
                      decoration: InputDecoration(
                        hintText: 'Masukkan kata sandi',
                        hintStyle: const TextStyle(
                          color: Colors.black45,
                          fontSize: 14,
                        ),
                        enabledBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: darkGreen,
                          ),
                        ),
                        focusedBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: darkGreen,
                            width: 2,
                          ),
                        ),
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              // ganti mode hidden pw
                              obscurePassword = !obscurePassword;
                            });
                          },
                          icon: Icon(
                            obscurePassword
                                ? Icons.visibility_off
                                : Icons.visibility,
                            color: darkGreen,
                            size: 20,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 28),

                    SizedBox(
                      width: double.infinity,
                      height: 53,
                      child: ElevatedButton(
                        onPressed: () {
                          // klo input kosong, kasih pesan
                          if (emailController.text.isEmpty ||
                              passwordController.text.isEmpty) {
                            showMessage(
                              'Email dan kata sandi wajib diisi.',
                            );
                          } else {
                            showMessage(
                              'Fitur login akan dihubungkan ke backend.',
                            );
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: darkGreen,
                          foregroundColor: Colors.white,
                          elevation: 2,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
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

                    const SizedBox(height: 12),

                    SizedBox(
                      width: double.infinity,
                      height: 53,
                      child: OutlinedButton(
                        onPressed: () {
                          showMessage(
                            'Halaman daftar warga akan dibuat berikutnya.',
                          );
                        },
                        style: OutlinedButton.styleFrom(
                          foregroundColor: darkGreen,
                          side: const BorderSide(
                            color: darkGreen,
                            width: 1.5,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                        ),
                        child: const Text(
                          'Daftar sebagai warga',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 25),

                    const Center(
                      child: Text(
                        'Petugas dan Pengelola masuk dengan akun dari Pengelola.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 12,
                          color: darkGreen,
                          height: 1.5,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}