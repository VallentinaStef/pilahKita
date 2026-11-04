import 'package:flutter/material.dart';

import '../../../data/models/task.dart';
import '../../theme/app_colors.dart';
import '../../widgets/petugas/section_header.dart';
import '../../widgets/petugas/task_card.dart';
import 'empty_tasks_page.dart';

class TaskListPage extends StatelessWidget {
  final List<Task> tasks;
  final bool showEmptyPreview;
  final VoidCallback onShowTasks;
  final ValueChanged<Task> onTaskTap;

  const TaskListPage({
    super.key,
    required this.tasks,
    required this.showEmptyPreview,
    required this.onShowTasks,
    required this.onTaskTap,
  });

  @override
  Widget build(BuildContext context) {
    if (showEmptyPreview || tasks.isEmpty) {
      return EmptyTasksPage(onShowTasks: onShowTasks);
    }

    return ListView(
      padding: const EdgeInsets.all(18),
      children: [
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: AppColors.yellow,
            borderRadius: BorderRadius.circular(24),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Pak Dedi, hari ini kamu punya',
                style: TextStyle(fontSize: 13, color: AppColors.textDark),
              ),
              const SizedBox(height: 4),
              Text(
                '${tasks.length} tugas',
                style: const TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.w900,
                  color: AppColors.textDark,
                ),
              ),
              const SizedBox(height: 5),
              const Text(
                'Selesaikan tugas dan unggah bukti pembersihan.',
                style: TextStyle(fontSize: 12, color: AppColors.textDark),
              ),
            ],
          ),
        ),
        const SizedBox(height: 22),
        const SectionHeader(
          title: 'Tugas hari ini',
          subtitle: 'Pilih tugas untuk melihat detailnya.',
        ),
        const SizedBox(height: 12),
        ...tasks.map(
          (task) => TaskCard(
            task: task,
            onTap: () => onTaskTap(task),
          ),
        ),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
          ),
          child: const Row(
            children: [
              Icon(Icons.info_outline, color: AppColors.green),
              SizedBox(width: 10),
              Expanded(
                child: Text(
                  'Pilih salah satu tiket untuk melihat detail dan memulai pengerjaan.',
                  style: TextStyle(fontSize: 12, color: AppColors.textGrey),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}