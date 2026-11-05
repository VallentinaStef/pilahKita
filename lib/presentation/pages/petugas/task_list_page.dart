import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../domain/entities/task.dart';
import '../../themes/app_colors.dart';
import '../../widgets/petugas/task_card.dart';
import 'empty_tasks_page.dart';

class TaskListPage extends StatelessWidget {
  final String namaPetugas;
  final List<Task> tasks;
  final ValueChanged<Task> onTaskTap;
  final VoidCallback onHistoryTap;
  const TaskListPage({
    super.key,
    required this.namaPetugas,
    required this.tasks,
    required this.onTaskTap,
    required this.onHistoryTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.fromLTRB(22, 23, 22, 24),
          decoration: const BoxDecoration(
            color: Color(0xFFFFC400),
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(34)),
          ),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Pak $namaPetugas, hari ini kamu punya',
                      style: const TextStyle(
                        color: Color(0xFF745D16),
                        fontSize: 11,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      '${tasks.length} tugas',
                      style: const TextStyle(
                        color: AppColors.primary,
                        fontSize: 35,
                        fontWeight: FontWeight.w900,
                        height: 1.1,
                      ),
                    ),
                  ],
                ),
              ),
              SvgPicture.asset(
                'lib/assets/icons8-trash-400.svg',
                width: 48,
                height: 48,
              ),
            ],
          ),
        ),
        Expanded(
          child:
              tasks.isEmpty
                  ? const EmptyTasksPage(compact: true)
                  : ListView(
                    padding: const EdgeInsets.fromLTRB(16, 17, 16, 18),
                    children: [
                      ...tasks.map(
                        (task) =>
                            TaskCard(task: task, onTap: () => onTaskTap(task)),
                      ),
                      const SizedBox(height: 3),
                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton.icon(
                          onPressed: onHistoryTap,
                          icon: const Icon(Icons.history, size: 17),
                          label: const Text('Riwayat tugas'),
                          style: TextButton.styleFrom(
                            foregroundColor: AppColors.primary,
                          ),
                        ),
                      ),
                    ],
                  ),
        ),
      ],
    );
  }
}