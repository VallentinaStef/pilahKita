import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../domain/entities/task.dart';
import '../../themes/app_colors.dart';
import '../../widgets/petugas/petugas_page_frame.dart';

class TaskCompletedPage extends StatelessWidget {
  final Task task;
  final int completedTodayCount;
  final int remainingTaskCount;
  const TaskCompletedPage({
    super.key,
    required this.task,
    required this.completedTodayCount,
    required this.remainingTaskCount,
  });
  void _back(BuildContext context) =>
      Navigator.popUntil(context, (route) => route.isFirst);

  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: AppColors.background,
    body: PetugasPageFrame(
      child: SafeArea(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.fromLTRB(22, 24, 22, 28),
              decoration: const BoxDecoration(
                color: Color(0xFFFFC400),
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(60),
                ),
              ),
              child: Column(
                children: [
                  SvgPicture.asset(
                    'lib/assets/icons8-trash-400.svg',
                    width: 90,
                    height: 90,
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Tugas selesai',
                    style: TextStyle(
                      color: AppColors.primary,
                      fontSize: 27,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  const SizedBox(height: 5),
                  const Text(
                    'Warga yang melapor sudah diberi tahu.',
                    style: TextStyle(color: Color(0xFF745D16), fontSize: 11),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 15),
                children: [
                  Container(
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(14),
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
                                fontSize: 18,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                            const Spacer(),
                            _DoneBadge(),
                          ],
                        ),
                        const SizedBox(height: 12),
                        Text(
                          task.address,
                          style: const TextStyle(
                            color: AppColors.textSecondary,
                            fontSize: 12,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Selesai ${task.completedAtLabel ?? 'Hari ini, 08.02'}. Foto bukti tersimpan.',
                          style: const TextStyle(
                            color: AppColors.textSecondary,
                            fontSize: 11,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 18),
                  Row(
                    children: [
                      Expanded(
                        child: _Stat(
                          value: '$completedTodayCount',
                          label: 'Selesai hari ini',
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _Stat(
                          value: '$remainingTaskCount',
                          label: 'Tugas tersisa',
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 22),
                  SizedBox(
                    height: 52,
                    child: ElevatedButton(
                      onPressed: () => _back(context),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text(
                        'Kembali ke daftar tugas',
                        style: TextStyle(fontWeight: FontWeight.w800),
                      ),
                    ),
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

class _DoneBadge extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 4),
    decoration: BoxDecoration(
      border: Border.all(color: AppColors.success),
      borderRadius: BorderRadius.circular(8),
    ),
    child: const Text(
      'Selesai',
      style: TextStyle(
        color: AppColors.success,
        fontSize: 10,
        fontWeight: FontWeight.w800,
      ),
    ),
  );
}

class _Stat extends StatelessWidget {
  final String value;
  final String label;
  const _Stat({required this.value, required this.label});
  @override
  Widget build(BuildContext context) => Column(
    children: [
      Text(
        value,
        style: const TextStyle(
          color: AppColors.primary,
          fontSize: 28,
          fontWeight: FontWeight.w900,
        ),
      ),
      Text(
        label,
        style: const TextStyle(color: AppColors.textSecondary, fontSize: 11),
      ),
    ],
  );
}