import 'package:flutter/material.dart';
import '../../../domain/entities/task.dart';
import '../../themes/app_colors.dart';
import '../../widgets/petugas/map_placeholder.dart';
import '../../widgets/petugas/petugas_page_frame.dart';
import '../../widgets/petugas/primary_action_button.dart';
import '../../widgets/petugas/status_badge.dart';
import '../../widgets/petugas/task_info_card.dart';
import 'evidence_page.dart';

class TaskDetailPage extends StatelessWidget {
  final Task task;
  final ValueChanged<Task> onTaskStarted;
  final ValueChanged<Task> onTaskCompleted;
  final int Function() getCompletedTodayCount;
  final int Function() getRemainingTaskCount;
  const TaskDetailPage({
    super.key,
    required this.task,
    required this.onTaskStarted,
    required this.onTaskCompleted,
    required this.getCompletedTodayCount,
    required this.getRemainingTaskCount,
  });

  void _startTask(BuildContext context) {
    onTaskStarted(task);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder:
            (_) => EvidencePage(
              task: task,
              onTaskCompleted: onTaskCompleted,
              getCompletedTodayCount: getCompletedTodayCount,
              getRemainingTaskCount: getRemainingTaskCount,
            ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: AppColors.background,
    body: PetugasPageFrame(
      child: SafeArea(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            MapPlaceholder(address: task.address, height: 300),
            Transform.translate(
              offset: const Offset(0, -22),
              child: Container(
                padding: const EdgeInsets.fromLTRB(18, 17, 18, 22),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          task.id,
                          style: const TextStyle(
                            color: AppColors.primary,
                            fontSize: 22,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                        const Spacer(),
                        StatusBadge(status: task.status),
                      ],
                    ),
                    const SizedBox(height: 12),
                    TaskInfoCard(task: task),
                    const SizedBox(height: 18),
                    OutlinedButton(
                      onPressed:
                          () => ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                'Navigasi Google Maps belum dihubungkan.',
                              ),
                            ),
                          ),
                      style: OutlinedButton.styleFrom(
                        minimumSize: const Size.fromHeight(49),
                        foregroundColor: AppColors.primary,
                        side: const BorderSide(
                          color: AppColors.primary,
                          width: 1.3,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(11),
                        ),
                      ),
                      child: const Text(
                        'Buka navigasi Google Maps',
                        style: TextStyle(fontWeight: FontWeight.w700),
                      ),
                    ),
                    const SizedBox(height: 10),
                    PrimaryActionButton(
                      text:
                          task.isInProgress
                              ? 'Lanjutkan pengerjaan'
                              : 'Mulai pengerjaan',
                      onPressed: () => _startTask(context),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}