import 'package:flutter/material.dart';
import '../../../domain/entities/task.dart';
import '../../themes/app_colors.dart';
import '../../widgets/petugas/petugas_bottom_nav.dart';
import '../../widgets/petugas/petugas_page_frame.dart';
import '../../widgets/petugas/photo_placeholder.dart';
import '../../widgets/petugas/status_badge.dart';
import 'task_history_detail_page.dart';

class TaskHistoryPage extends StatefulWidget {
  final List<Task> tasks;
  final ValueChanged<int>? onBottomNavTap;
  const TaskHistoryPage({super.key, required this.tasks, this.onBottomNavTap});
  @override
  State<TaskHistoryPage> createState() => _TaskHistoryPageState();
}

class _TaskHistoryPageState extends State<TaskHistoryPage> {
  String _filter = 'Bulan ini';
  List<Task> get _filteredTasks {
    if (_filter == 'Minggu ini')
      return widget.tasks
          .where(
            (task) =>
                (task.completedAtLabel ?? '').contains('Hari ini') ||
                (task.completedAtLabel ?? '').contains('28 Okt'),
          )
          .toList();
    return widget.tasks;
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: AppColors.background,
    body: PetugasPageFrame(
      child: SafeArea(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.fromLTRB(20, 24, 20, 18),
              decoration: const BoxDecoration(
                color: Color(0xFFFFC400),
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(34),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Riwayat tugas',
                    style: TextStyle(
                      color: AppColors.primary,
                      fontSize: 25,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      _Filter(
                        label: 'Bulan ini',
                        selected: _filter == 'Bulan ini',
                        onTap: () => setState(() => _filter = 'Bulan ini'),
                      ),
                      const SizedBox(width: 8),
                      _Filter(
                        label: 'Minggu ini',
                        selected: _filter == 'Minggu ini',
                        onTap: () => setState(() => _filter = 'Minggu ini'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.fromLTRB(17, 12, 17, 15),
                children:
                    _filteredTasks
                        .map(
                          (task) => _HistoryRow(
                            task: task,
                            onTap:
                                () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder:
                                        (_) =>
                                            TaskHistoryDetailPage(task: task),
                                  ),
                                ),
                          ),
                        )
                        .toList(),
              ),
            ),
          ],
        ),
      ),
    ),
    bottomNavigationBar:
        widget.onBottomNavTap == null
            ? null
            : PetugasPageFrame(
              child: PetugasBottomNav(
                currentIndex: 0,
                onTap: widget.onBottomNavTap!,
              ),
            ),
  );
}

class _Filter extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback onTap;
  const _Filter({
    required this.label,
    required this.selected,
    required this.onTap,
  });
  @override
  Widget build(BuildContext context) => InkWell(
    onTap: onTap,
    borderRadius: BorderRadius.circular(18),
    child: Container(
      padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 7),
      decoration: BoxDecoration(
        color: selected ? AppColors.primary : const Color(0xFFFFE078),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: selected ? Colors.white : AppColors.primary,
          fontSize: 10,
          fontWeight: FontWeight.w800,
        ),
      ),
    ),
  );
}

class _HistoryRow extends StatelessWidget {
  final Task task;
  final VoidCallback onTap;
  const _HistoryRow({required this.task, required this.onTap});
  @override
  Widget build(BuildContext context) => InkWell(
    onTap: onTap,
    child: Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: Color(0xFFD8E4D2))),
      ),
      child: Row(
        children: [
          SizedBox(
            width: 58,
            height: 58,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(5),
              child: const PhotoPlaceholder(title: '', height: 58),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  task.id,
                  style: const TextStyle(
                    color: AppColors.primary,
                    fontSize: 13,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  '${task.address}, ${task.completedAtLabel ?? ''}',
                  style: const TextStyle(
                    color: AppColors.textSecondary,
                    fontSize: 10,
                  ),
                ),
              ],
            ),
          ),
          StatusBadge(status: task.status),
        ],
      ),
    ),
  );
}