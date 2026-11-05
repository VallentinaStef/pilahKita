import 'package:flutter/material.dart';
import 'package:pilahkita/presentation/pages/petugas/evidence.preview_page.dart';
import '../../../domain/entities/task.dart';
import '../../themes/app_colors.dart';
import '../../widgets/petugas/petugas_page_frame.dart';
import 'gps_failed_page.dart';

class EvidencePage extends StatefulWidget {
  final Task task;
  final ValueChanged<Task> onTaskCompleted;
  final int Function() getCompletedTodayCount;
  final int Function() getRemainingTaskCount;
  const EvidencePage({
    super.key,
    required this.task,
    required this.onTaskCompleted,
    required this.getCompletedTodayCount,
    required this.getRemainingTaskCount,
  });
  @override
  State<EvidencePage> createState() => _EvidencePageState();
}

class _EvidencePageState extends State<EvidencePage> {
  bool _photoReady = false;
  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: AppColors.background,
    body: PetugasPageFrame(
      child: SafeArea(
        child: Column(
          children: [
            Expanded(
              flex: 5,
              child: Container(
                width: double.infinity,
                color: const Color(0xFF003C29),
                child: Stack(
                  children: [
                    Positioned.fill(
                      child: CustomPaint(painter: _DarkStripePainter()),
                    ),
                    Align(
                      alignment: const Alignment(0, -.25),
                      child: SizedBox(
                        width: 220,
                        height: 170,
                        child: Stack(
                          children: [
                            _corner(0, 0, false, false),
                            _corner(null, 0, true, false),
                            _corner(0, null, false, true),
                            _corner(null, null, true, true),
                            Center(
                              child: Text(
                                _photoReady
                                    ? 'Foto bukti siap'
                                    : 'Arahkan ke area yang sudah bersih',
                                style: const TextStyle(
                                  color: Colors.white70,
                                  fontSize: 12,
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
            Expanded(
              flex: 6,
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
                      'Foto bukti',
                      style: TextStyle(
                        color: AppColors.primary,
                        fontSize: 22,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Container(
                      padding: const EdgeInsets.all(13),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: const Row(
                        children: [
                          Icon(
                            Icons.my_location,
                            color: Color(0xFF36A66B),
                            size: 26,
                          ),
                          SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Lokasi sesuai',
                                  style: TextStyle(
                                    color: Color(0xFF16845A),
                                    fontSize: 13,
                                    fontWeight: FontWeight.w900,
                                  ),
                                ),
                                SizedBox(height: 3),
                                Text(
                                  'Kamu 18 m dari titik laporan. Batas 50 m.',
                                  style: TextStyle(
                                    color: AppColors.textSecondary,
                                    fontSize: 11,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Spacer(),
                    Center(
                      child: InkWell(
                        onTap: () {
                          setState(() => _photoReady = true);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder:
                                  (_) => EvidencePreviewPage(
                                    task: widget.task,
                                    onTaskCompleted: widget.onTaskCompleted,
                                    getCompletedTodayCount:
                                        widget.getCompletedTodayCount,
                                    getRemainingTaskCount:
                                        widget.getRemainingTaskCount,
                                  ),
                            ),
                          );
                        },
                        borderRadius: BorderRadius.circular(50),
                        child: Container(
                          width: 76,
                          height: 76,
                          decoration: BoxDecoration(
                            color: AppColors.primary,
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.white, width: 5),
                            boxShadow: const [
                              BoxShadow(
                                color: Color(0x33000000),
                                blurRadius: 6,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Center(
                      child: Text(
                        'Ketuk untuk memotret',
                        style: TextStyle(
                          color: AppColors.textSecondary,
                          fontSize: 11,
                        ),
                      ),
                    ),
                    const Spacer(),
                    TextButton(
                      onPressed:
                          () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const GpsFailedPage(),
                            ),
                          ),
                      child: const Center(
                        child: Text(
                          'Lihat contoh GPS gagal',
                          style: TextStyle(
                            color: AppColors.textSecondary,
                            fontSize: 10,
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

  Widget _corner(
    double? left,
    double? top,
    bool right,
    bool bottom,
  ) => Positioned(
    left: right ? null : left,
    right: right ? 0 : null,
    top: bottom ? null : top,
    bottom: bottom ? 0 : null,
    child: Container(
      width: 42,
      height: 42,
      decoration: BoxDecoration(
        border: Border(
          left:
              right
                  ? BorderSide.none
                  : const BorderSide(color: AppColors.accent, width: 5),
          right:
              right
                  ? const BorderSide(color: AppColors.accent, width: 5)
                  : BorderSide.none,
          top:
              bottom
                  ? BorderSide.none
                  : const BorderSide(color: AppColors.accent, width: 5),
          bottom:
              bottom
                  ? const BorderSide(color: AppColors.accent, width: 5)
                  : BorderSide.none,
        ),
        borderRadius: BorderRadius.only(
          topLeft: !right && !bottom ? const Radius.circular(18) : Radius.zero,
          topRight: right && !bottom ? const Radius.circular(18) : Radius.zero,
          bottomLeft:
              !right && bottom ? const Radius.circular(18) : Radius.zero,
          bottomRight:
              right && bottom ? const Radius.circular(18) : Radius.zero,
        ),
      ),
    ),
  );
}

class _DarkStripePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final p =
        Paint()
          ..color = Colors.white.withOpacity(.035)
          ..strokeWidth = 12;
    for (double x = -size.height; x < size.width + size.height; x += 28) {
      canvas.drawLine(Offset(x, size.height), Offset(x + size.height, 0), p);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}