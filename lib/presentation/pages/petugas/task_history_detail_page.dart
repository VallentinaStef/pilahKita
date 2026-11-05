import 'package:flutter/material.dart';
import '../../../domain/entities/task.dart';
import '../../themes/app_colors.dart';
import '../../widgets/petugas/map_placeholder.dart';
import '../../widgets/petugas/petugas_page_frame.dart';
import '../../widgets/petugas/photo_placeholder.dart';
import '../../widgets/petugas/status_badge.dart';

class TaskHistoryDetailPage extends StatelessWidget {
  final Task task;
  const TaskHistoryDetailPage({super.key, required this.task});
  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: AppColors.background,
    body: PetugasPageFrame(
      child: SafeArea(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            Container(
              padding: const EdgeInsets.fromLTRB(20, 23, 20, 24),
              decoration: const BoxDecoration(
                color: Color(0xFFFFC400),
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(32),
                ),
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
                          fontSize: 24,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      const Spacer(),
                      StatusBadge(status: task.status),
                    ],
                  ),
                  const SizedBox(height: 5),
                  Text(
                    'Diselesaikan ${task.completedAtLabel ?? '28 Okt, 16.02'} dari jarak ${task.completedDistanceLabel ?? '18 m'}',
                    style: const TextStyle(
                      color: Color(0xFF745D16),
                      fontSize: 11,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(18, 17, 18, 22),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          children: [
                            const PhotoPlaceholder(
                              title: 'Foto warga',
                              height: 100,
                            ),
                            const Text(
                              'Laporan',
                              style: TextStyle(
                                color: AppColors.textSecondary,
                                fontSize: 10,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          children: [
                            const PhotoPlaceholder(
                              title: 'Foto bukti',
                              height: 100,
                            ),
                            const Text(
                              'Bukti',
                              style: TextStyle(
                                color: AppColors.textSecondary,
                                fontSize: 10,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 14),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(18),
                    child: MapPlaceholder(address: task.address, height: 130),
                  ),
                  const SizedBox(height: 15),
                  Row(
                    children: [
                      const Icon(
                        Icons.delete,
                        color: Color(0xFF00A66A),
                        size: 25,
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              task.address,
                              style: const TextStyle(
                                color: AppColors.primary,
                                fontSize: 12,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                            Text(
                              '${task.wasteType}, volume ${task.volume.toLowerCase()}',
                              style: const TextStyle(
                                color: AppColors.textSecondary,
                                fontSize: 11,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ),
  );
}