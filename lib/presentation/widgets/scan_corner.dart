import 'package:flutter/material.dart';
import '../themes/app_colors.dart';

// Satu sudut bingkai kamera. Caranya: kotak berbingkai penuh dipotong
// jadi seperempat, jadi yang kelihatan hanya satu sudutnya.
class ScanCorner extends StatelessWidget {
  final Alignment corner; // topLeft, topRight, bottomLeft, atau bottomRight

  const ScanCorner({super.key, required this.corner});

  @override
  Widget build(BuildContext context) {
    return ClipRect(
      child: Align(
        alignment: corner,
        widthFactor: 0.5,
        heightFactor: 0.5,
        child: Container(
          width: 120,
          height: 120,
          decoration: BoxDecoration(
            border: Border.all(color: AppColors.accent, width: 4),
            borderRadius: BorderRadius.circular(28),
          ),
        ),
      ),
    );
  }
}
