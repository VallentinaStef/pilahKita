import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../theme/app_colors.dart';
import '../widgets/app_button.dart';
import '../widgets/app_text_field.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  bool loginFailed = false;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void login() {
    if (passwordController.text.length < 8) {
      setState(() {
        loginFailed = true;
      });
    } else {
      setState(() {
        loginFailed = false;
      });
      // todo: tambah route ke dashboard
    }
  }

  @override
  Widget build(BuildContext context) {
    final statusBarHeight = MediaQuery.of(context).padding.top;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: AppColors.green,
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.elliptical(screenWidth / 2, 40),
                ),
              ),
              padding: EdgeInsets.fromLTRB(24, statusBarHeight + 56, 24, 40),
              child: Column(
                children: [
                  SvgPicture.asset(
                    'lib/assets/icons8-trash-400.svg',
                    width: 120,
                    height: 130,
                  ),
                  Text(
                    'PilahKita',
                    style: GoogleFonts.bricolageGrotesque(
                      fontSize: 40,
                      fontWeight: FontWeight.w800,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Lihat sampah liar? Foto, kirim, pantau sampai bersih.',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white, fontSize: 13),
                  ),
                ],
              ),
            ),

            // Form
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 24, 24, 32),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Pesan error
                  if (loginFailed) ...[
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: AppColors.pink,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '!',
                            style: TextStyle(
                              color: AppColors.red,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              'Email atau kata sandi salah. Periksa lagi isiannya.',
                              style: TextStyle(color: AppColors.red),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                  ],

                  AppTextField(
                    label: 'Email',
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                    hasError: loginFailed,
                  ),
                  const SizedBox(height: 8),
                  AppTextField(
                    label: 'Kata sandi',
                    controller: passwordController,
                    obscureText: true,
                    hasError: loginFailed,
                  ),
                  const SizedBox(height: 16),

                  AppButton(text: 'Masuk', onPressed: login),
                  const SizedBox(height: 16),

                  AppButton(
                    text: 'Daftar sebagai warga',
                    outlined: true,
                    onPressed: () {
                      // todo: pindah ke register
                    },
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
