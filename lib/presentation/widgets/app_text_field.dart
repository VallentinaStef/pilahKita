import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

class AppTextField extends StatelessWidget {
  final String label;
  final TextEditingController? controller;
  final bool obscureText;
  final bool hasError;
  final TextInputType? keyboardType;

  const AppTextField({
    super.key,
    required this.label,
    this.controller,
    this.obscureText = false,
    this.hasError = false,
    this.keyboardType,
  });

  @override
  Widget build(BuildContext context) {
    final lineColor = hasError ? AppColors.red : AppColors.textDark;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
        ),
        TextField(
          controller: controller,
          obscureText: obscureText,
          keyboardType: keyboardType,
          style: const TextStyle(fontSize: 14),
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(vertical: 16),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: lineColor, width: 1.5),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: lineColor, width: 2.5),
            ),
          ),
        ),
      ],
    );
  }
}
