import 'package:flutter/material.dart';
import '../../../domain/entities/task.dart';
import '../../themes/app_colors.dart';

class StatusBadge extends StatelessWidget {
  final TaskStatus status;
  const StatusBadge({super.key, required this.status});

  @override
  Widget build(BuildContext context) {
    late Color color;
    late String label;
    switch (status) {
      case TaskStatus.ditugaskan:
        color = const Color(0xFF315D75);
        label = 'Ditugaskan';
        break;
      case TaskStatus.dalamProses:
        color = const Color(0xFF9A4D25);
        label = 'Dalam proses';
        break;
      case TaskStatus.selesai:
        color = AppColors.success;
        label = 'Selesai';
        break;
    }
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: color, width: 1.2),
        borderRadius: BorderRadius.circular(9),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: color,
          fontSize: 10,
          fontWeight: FontWeight.w800,
        ),
      ),
    );
  }
}