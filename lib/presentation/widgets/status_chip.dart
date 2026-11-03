import 'package:flutter/material.dart';

import '../../core/config/app_theme.dart';
import '../../domain/entities/laporan.dart';

class StatusChip extends StatelessWidget {
  final StatusLaporan status;

  const StatusChip({super.key, required this.status});

  Color get _color => switch (status) {
        StatusLaporan.menunggu => AppTheme.warning,
        StatusLaporan.diproses => AppTheme.processing,
        StatusLaporan.selesai => AppTheme.success,
        StatusLaporan.ditolak => AppTheme.danger,
      };

  @override
  Widget build(BuildContext context) {
    final label = switch (status) {
      StatusLaporan.menunggu => 'Menunggu validasi',
      StatusLaporan.diproses => 'Dalam proses',
      StatusLaporan.selesai => 'Selesai',
      StatusLaporan.ditolak => 'Ditolak',
    };

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: _color, width: 1.3),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: _color,
          fontSize: 11,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
