import 'package:flutter/material.dart';
import '../../domain/entities/laporan.dart';
import '../themes/app_colors.dart';
import 'status_stamp.dart';

class ReportSummaryCard extends StatelessWidget {
  final Laporan report;

  const ReportSummaryCard({super.key, required this.report});

  @override
  Widget build(BuildContext context) {
    final officer = report.petugas;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withValues(alpha: 0.1),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                report.tiket,
                style: const TextStyle(
                  color: AppColors.textPrimary,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
              StatusStamp(label: report.statusLabel),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            officer == null
                ? report.alamat
                : '${report.alamat}. Petugas: $officer',
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(color: AppColors.textSecondary, fontSize: 12),
          ),
        ],
      ),
    );
  }
}
