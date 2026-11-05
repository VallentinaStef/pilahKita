import 'package:flutter/material.dart';
import '../../../domain/entities/task.dart';
import '../../themes/app_colors.dart';
import '../../widgets/petugas/photo_placeholder.dart';
import '../../widgets/petugas/petugas_page_frame.dart';
import 'task_completed_page.dart';
import 'upload_failed_page.dart';

class EvidencePreviewPage extends StatelessWidget {
  final Task task;
  final ValueChanged<Task> onTaskCompleted;
  final int Function() getCompletedTodayCount;
  final int Function() getRemainingTaskCount;
  const EvidencePreviewPage({
    super.key,
    required this.task,
    required this.onTaskCompleted,
    required this.getCompletedTodayCount,
    required this.getRemainingTaskCount,
  });

  void _complete(BuildContext context) {
    onTaskCompleted(task);
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder:
            (_) => TaskCompletedPage(
              task: task,
              completedTodayCount: getCompletedTodayCount(),
              remainingTaskCount: getRemainingTaskCount(),
            ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: const Color(0xFF003C29),
    body: PetugasPageFrame(
      child: SafeArea(
        child: Column(
          children: [
            Expanded(
              flex: 6,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(22, 24, 22, 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Pratinjau foto',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                        fontSize: 13,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Expanded(
                      child: PhotoPlaceholder(
                        title: 'Foto hasil pembersihan',
                        height: 300,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 5,
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.fromLTRB(20, 18, 20, 18),
                decoration: const BoxDecoration(
                  color: Color(0xFFE8F4E2),
                  borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Sudah sesuai?',
                      style: TextStyle(
                        color: AppColors.primary,
                        fontSize: 22,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 13,
                        vertical: 10,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFFD6F3B6),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Row(
                        children: [
                          Icon(
                            Icons.check_circle,
                            color: Color(0xFF16845A),
                            size: 17,
                          ),
                          SizedBox(width: 7),
                          Expanded(
                            child: Text(
                              'Lokasi sesuai   18 m dari titik. Diambil 07.58',
                              style: TextStyle(
                                color: Color(0xFF16845A),
                                fontSize: 10,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Spacer(),
                    SizedBox(
                      width: double.infinity,
                      height: 52,
                      child: ElevatedButton(
                        onPressed: () => _complete(context),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: const Text(
                          'Selesaikan tugas',
                          style: TextStyle(fontWeight: FontWeight.w800),
                        ),
                      ),
                    ),
                    const SizedBox(height: 9),
                    SizedBox(
                      width: double.infinity,
                      height: 48,
                      child: OutlinedButton(
                        onPressed: () => Navigator.pop(context),
                        style: OutlinedButton.styleFrom(
                          foregroundColor: AppColors.primary,
                          side: const BorderSide(
                            color: AppColors.primary,
                            width: 1.4,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: const Text(
                          'Ulangi foto',
                          style: TextStyle(fontWeight: FontWeight.w700),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: TextButton(
                        onPressed:
                            () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const UploadFailedPage(),
                              ),
                            ),
                        child: const Text(
                          'Lihat contoh gagal unggah',
                          style: TextStyle(
                            fontSize: 10,
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ),
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