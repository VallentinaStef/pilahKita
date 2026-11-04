import 'package:flutter/material.dart';

import '../../../data/models/task.dart';
import '../../theme/app_colors.dart';
import '../../widgets/petugas/map_placeholder.dart';
import '../../widgets/petugas/primary_action_button.dart';
import '../../widgets/petugas/status_badge.dart';
import '../../widgets/petugas/task_info_card.dart';
import 'evidence_page.dart';

class TaskDetailPage extends StatelessWidget {
  final Task task;
  final VoidCallback onTaskCompleted;
  final int Function() getCompletedTodayCount;
  final int Function() getRemainingTaskCount;

  const TaskDetailPage({
    super.key,
    required this.task,
    required this.onTaskCompleted,
    required this.getCompletedTodayCount,
    required this.getRemainingTaskCount,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Detail tugas')),
      body: ListView(
        padding: const EdgeInsets.all(18),
        children: [
          MapPlaceholder(address: task.address),
          const SizedBox(height: 18),
          Row(
            children: [
              Text(
                task.id,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textDark,
                ),
              ),
              const Spacer(),
              StatusBadge(status: task.status),
            ],
          ),
          const SizedBox(height: 14),
          TaskInfoCard(task: task),
          const SizedBox(height: 18),
          OutlinedButton.icon(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text(
                    'Peta masih berupa ilustrasi. Navigasi Google Maps belum dihubungkan.',
                  ),
                ),
              );
            },
            icon: const Icon(Icons.map_outlined),
            label: const Text('Buka navigasi Google Maps'),
            style: OutlinedButton.styleFrom(
              foregroundColor: AppColors.green,
              padding: const EdgeInsets.symmetric(vertical: 15),
            ),
          ),
          const SizedBox(height: 10),
          PrimaryActionButton(
            text: 'Mulai pengerjaan',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => EvidencePage(
                    task: task,
                    onTaskCompleted: onTaskCompleted,
                    getCompletedTodayCount: getCompletedTodayCount,
                    getRemainingTaskCount: getRemainingTaskCount,
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}