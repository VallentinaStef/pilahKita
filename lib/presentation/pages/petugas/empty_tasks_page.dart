import 'package:flutter/material.dart';

import '../../theme/app_colors.dart';
import '../../widgets/petugas/primary_action_button.dart';

class EmptyTasksPage extends StatelessWidget {
  final VoidCallback onShowTasks;

  const EmptyTasksPage({
    super.key,
    required this.onShowTasks,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(28),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 110,
              height: 110,
              decoration: const BoxDecoration(
                color: AppColors.line,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.delete_outline,
                size: 60,
                color: AppColors.green,
              ),
            ),
            const SizedBox(height: 18),
            const Text(
              'Belum ada tugas',
              style: TextStyle(
                color: AppColors.textDark,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Tugas baru akan muncul di sini setelah Pengelola menugaskan laporan kepadamu.',
              textAlign: TextAlign.center,
              style: TextStyle(color: AppColors.textGrey, height: 1.5),
            ),
            const SizedBox(height: 22),
            PrimaryActionButton(
              text: 'Tampilkan tugas contoh',
              onPressed: onShowTasks,
            ),
          ],
        ),
      ),
    );
  }
}