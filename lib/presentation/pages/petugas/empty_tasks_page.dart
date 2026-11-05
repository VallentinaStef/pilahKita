import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../themes/app_colors.dart';

class EmptyTasksPage extends StatelessWidget {
  final bool compact;
  const EmptyTasksPage({super.key, this.compact = false});
  @override
  Widget build(BuildContext context) => Center(
    child: Padding(
      padding: const EdgeInsets.all(28),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SvgPicture.asset(
            'lib/assets/icons8-trash-400.svg',
            width: 92,
            height: 92,
          ),
          const SizedBox(height: 15),
          const Text(
            'Belum ada tugas',
            style: TextStyle(
              color: AppColors.primary,
              fontSize: 19,
              fontWeight: FontWeight.w900,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Tugas baru muncul di sini setelah Pengelola menugaskan laporan kepadamu.',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: AppColors.textSecondary,
              fontSize: 12,
              height: 1.45,
            ),
          ),
        ],
      ),
    ),
  );
}