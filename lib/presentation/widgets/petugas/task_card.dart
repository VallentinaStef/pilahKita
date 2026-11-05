import 'package:flutter/material.dart';
import '../../../domain/entities/task.dart';
import '../../themes/app_colors.dart';
import 'status_badge.dart';

class TaskCard extends StatelessWidget {
  final Task task;
  final VoidCallback onTap;
  final bool history;
  const TaskCard({
    super.key,
    required this.task,
    required this.onTap,
    this.history = false,
  });

  Color get _binColor {
    if (task.wasteType == 'Organik') return const Color(0xFF00A66A);
    if (task.wasteType == 'Campuran') return const Color(0xFF8B5A2B);
    return const Color(0xFFFFC400);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 11),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(15),
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(14, 12, 14, 11),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Text(
                      'Tiket',
                      style: TextStyle(
                        color: AppColors.textSecondary,
                        fontSize: 10,
                      ),
                    ),
                    const Spacer(),
                    StatusBadge(status: task.status),
                  ],
                ),
                const SizedBox(height: 2),
                Text(
                  task.id,
                  style: const TextStyle(
                    color: AppColors.primary,
                    fontSize: 18,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const SizedBox(height: 9),
                const _DashedDivider(),
                const SizedBox(height: 10),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    _WasteBin(color: _binColor),
                    const SizedBox(width: 11),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            task.address,
                            style: const TextStyle(
                              color: AppColors.primary,
                              fontSize: 12,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            '${task.wasteType}, ${task.volume.toLowerCase()}, ${history ? (task.completedAtLabel ?? '') : '${task.distance} dari kamu'}',
                            style: const TextStyle(
                              color: AppColors.textSecondary,
                              fontSize: 11,
                            ),
                          ),
                        ],
                      ),
                    ),
                    if (history)
                      const Icon(
                        Icons.chevron_right,
                        color: AppColors.textSecondary,
                      ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _WasteBin extends StatelessWidget {
  final Color color;
  const _WasteBin({required this.color});
  @override
  Widget build(BuildContext context) => SizedBox(
    width: 27,
    height: 31,
    child: Stack(
      alignment: Alignment.topCenter,
      children: [
        Container(
          width: 22,
          height: 5,
          margin: const EdgeInsets.only(top: 3),
          decoration: BoxDecoration(
            color: AppColors.primary,
            borderRadius: BorderRadius.circular(3),
          ),
        ),
        Positioned(
          top: 8,
          child: Container(
            width: 18,
            height: 21,
            decoration: BoxDecoration(
              color: color,
              borderRadius: const BorderRadius.vertical(
                bottom: Radius.circular(5),
                top: Radius.circular(2),
              ),
            ),
          ),
        ),
      ],
    ),
  );
}

class _DashedDivider extends StatelessWidget {
  const _DashedDivider();
  @override
  Widget build(BuildContext context) => CustomPaint(
    painter: _DashPainter(),
    child: const SizedBox(height: 1, width: double.infinity),
  );
}

class _DashPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint =
        Paint()
          ..color = const Color(0xFFD8E2D4)
          ..strokeWidth = 1;
    for (double x = 0; x < size.width; x += 7) {
      canvas.drawLine(Offset(x, 0), Offset(x + 3, 0), paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}