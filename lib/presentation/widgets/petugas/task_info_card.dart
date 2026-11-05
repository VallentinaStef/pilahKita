import 'package:flutter/material.dart';
import '../../../domain/entities/task.dart';
import '../../themes/app_colors.dart';

class TaskInfoCard extends StatelessWidget {
  final Task task;
  const TaskInfoCard({super.key, required this.task});
  @override
  Widget build(BuildContext context) => Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const Icon(Icons.delete, color: Color(0xFFFFC400), size: 23),
      const SizedBox(width: 10),
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              task.address,
              style: const TextStyle(
                color: AppColors.primary,
                fontWeight: FontWeight.w800,
                fontSize: 12,
              ),
            ),
            const SizedBox(height: 3),
            Text(
              '${task.wasteType}, volume ${task.volume.toLowerCase()}, ${task.distance}, sekitar 6 menit',
              style: const TextStyle(
                color: AppColors.textSecondary,
                fontSize: 11,
                height: 1.35,
              ),
            ),
          ],
        ),
      ),
    ],
  );
}