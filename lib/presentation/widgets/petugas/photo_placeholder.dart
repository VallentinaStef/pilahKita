import 'package:flutter/material.dart';
import '../../themes/app_colors.dart';

class PhotoPlaceholder extends StatelessWidget {
  final String title;
  final bool isPreview;
  final double height;
  const PhotoPlaceholder({
    super.key,
    this.title = 'Foto hasil pembersihan',
    this.isPreview = false,
    this.height = 190,
  });

  @override
  Widget build(BuildContext context) => Container(
    height: height,
    width: double.infinity,
    decoration: BoxDecoration(
      color: const Color(0xFFD7EBD0),
      border: Border.all(color: Colors.white, width: 4),
      boxShadow: const [
        BoxShadow(
          color: Color(0x22000000),
          blurRadius: 7,
          offset: Offset(0, 3),
        ),
      ],
    ),
    child: Stack(
      children: [
        Positioned.fill(child: CustomPaint(painter: _StripePainter())),
        Center(
          child: Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: AppColors.primary,
              fontWeight: FontWeight.w700,
              fontSize: 12,
            ),
          ),
        ),
      ],
    ),
  );
}

class _StripePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint =
        Paint()
          ..color = Colors.white.withOpacity(.28)
          ..strokeWidth = 9;
    for (double x = -size.height; x < size.width + size.height; x += 24) {
      canvas.drawLine(
        Offset(x, size.height),
        Offset(x + size.height, 0),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}