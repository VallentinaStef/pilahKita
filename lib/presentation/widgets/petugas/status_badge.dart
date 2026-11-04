import 'package:flutter/material.dart';

import '../../theme/app_colors.dart';

class StatusBadge extends StatelessWidget {
  final String status;

  const StatusBadge({
    super.key,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    Color background;
    Color foreground;

    if (status == 'Selesai') {
      background = AppColors.line;
      foreground = AppColors.green;
    } else if (status == 'Dalam proses') {
      background = AppColors.pink;
      foreground = const Color(0xFF94600A);
    } else {
      background = AppColors.teal;
      foreground = const Color(0xFF405B9A);
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        status,
        style: TextStyle(
          color: foreground,
          fontSize: 10,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}