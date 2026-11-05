import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../../themes/app_colors.dart';

class MapPlaceholder extends StatelessWidget {
  final String address;
  final double height;
  final bool showAddress;
  const MapPlaceholder({
    super.key,
    required this.address,
    this.height = 260,
    this.showAddress = false,
  });
  @override
  Widget build(BuildContext context) => SizedBox(
    height: height,
    width: double.infinity,
    child: ClipRRect(
      borderRadius: BorderRadius.circular(0),
      child: Stack(
        children: [
          Positioned.fill(child: CustomPaint(painter: _MapPainter())),
          const Positioned(
            top: 62,
            left: 0,
            right: 0,
            child: Icon(Icons.location_on, color: Color(0xFFC84B25), size: 34),
          ),
          if (showAddress)
            Positioned(
              left: 14,
              right: 14,
              bottom: 12,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 9,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.place, color: AppColors.primary, size: 17),
                    const SizedBox(width: 7),
                    Expanded(
                      child: Text(
                        address,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: AppColors.primary,
                          fontSize: 11,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    ),
  );
}

class _MapPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawColor(const Color(0xFFDCEFD6), BlendMode.src);
    final park = Paint()..color = const Color(0xFFB7E5AC);
    canvas.drawOval(Rect.fromLTWH(8, 12, 120, 62), park);
    canvas.drawOval(
      Rect.fromLTWH(size.width - 115, size.height - 82, 120, 65),
      park,
    );
    final river =
        Paint()
          ..color = const Color(0xFF8CCBE0)
          ..style = PaintingStyle.stroke
          ..strokeWidth = 15;
    final riverPath =
        Path()
          ..moveTo(-20, size.height * .78)
          ..cubicTo(
            size.width * .25,
            size.height * .56,
            size.width * .58,
            size.height * .9,
            size.width + 25,
            size.height * .35,
          );
    canvas.drawPath(riverPath, river);
    final road =
        Paint()
          ..color = Colors.white
          ..strokeWidth = 8
          ..strokeCap = StrokeCap.round;
    canvas.drawLine(
      Offset(size.width * .28, -10),
      Offset(size.width * .48, size.height + 10),
      road,
    );
    canvas.drawLine(
      Offset(size.width * .70, -10),
      Offset(size.width * .58, size.height + 10),
      road,
    );
    canvas.drawLine(
      Offset(-10, size.height * .50),
      Offset(size.width + 10, size.height * .32),
      road,
    );
    final route =
        Paint()
          ..color = AppColors.primary
          ..strokeWidth = 3
          ..style = PaintingStyle.stroke
          ..strokeCap = StrokeCap.round;
    final start = Offset(size.width * .22, size.height * .84);
    final end = Offset(size.width * .48, size.height * .26);
    final dx = end.dx - start.dx;
    final dy = end.dy - start.dy;
    final length = math.sqrt(dx * dx + dy * dy);
    final segments = (length / 9).floor();
    for (int i = 0; i < segments; i += 2) {
      final a = i / segments;
      final b = (i + 1) / segments;
      canvas.drawLine(
        Offset(start.dx + dx * a, start.dy + dy * a),
        Offset(start.dx + dx * b, start.dy + dy * b),
        route,
      );
    }
    canvas.drawCircle(
      Offset(size.width * .22, size.height * .84),
      10,
      Paint()..color = const Color(0xFF9CC8D0),
    );
    canvas.drawCircle(
      Offset(size.width * .22, size.height * .84),
      5,
      Paint()..color = const Color(0xFF1C5D9A),
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}