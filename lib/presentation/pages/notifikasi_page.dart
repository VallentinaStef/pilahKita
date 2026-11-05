import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../themes/app_colors.dart';
import '../../domain/entities/notifikasi.dart';
import '../controllers/notifikasi_controller.dart';
import '../shell/home_shell.dart';

class NotifikasiPage extends StatefulWidget {
  final RolePengguna role;

  const NotifikasiPage({
    super.key,
    this.role = RolePengguna.warga,
  });

  @override
  State<NotifikasiPage> createState() => _NotifikasiPageState();
}

class _NotifikasiPageState extends State<NotifikasiPage> {
  late RolePengguna _role;

  @override
  void initState() {
    super.initState();
    _role = widget.role;
  }

  NotifikasiController get _controller => Get.find<NotifikasiController>(
        tag: _role == RolePengguna.petugas ? 'petugas' : null,
      );

  void _toggleRole() {
    setState(() {
      _role = _role == RolePengguna.warga
          ? RolePengguna.petugas
          : RolePengguna.warga;
    });
  }

  @override
  Widget build(BuildContext context) {
    final controller = _controller;
    final isiPetugas = _role == RolePengguna.petugas;

    return Scaffold(
      appBar: AppBar(
        title: Text(isiPetugas ? 'Notifikasi petugas' : 'Notifikasi'),
        actions: [
          IconButton(
            tooltip: isiPetugas
                ? 'Lihat sebagai warga'
                : 'Lihat sebagai petugas',
            icon: Icon(
              isiPetugas ? Icons.person : Icons.badge_outlined,
              color: AppColors.primary,
            ),
            onPressed: _toggleRole,
          ),
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: Center(
              child: Obx(() {
                final belum = controller.jumlahBelumDibaca;
                return Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: AppColors.surface,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: AppColors.primary, width: 1.2),
                  ),
                  child: Text(
                    '$belum belum dibaca',
                    style: const TextStyle(
                      fontSize: 11,
                      color: AppColors.primary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                );
              }),
            ),
          ),
        ],
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }
        final grupList = controller.grupList;
        if (grupList.isEmpty) {
          return const Center(
            child: Text(
              'Belum ada notifikasi',
              style: TextStyle(color: AppColors.textSecondary),
            ),
          );
        }
        return ListView(
          padding: const EdgeInsets.all(16),
          children: [
            for (final grup in grupList) ...[
              Padding(
                padding: const EdgeInsets.only(top: 8, bottom: 8),
                child: Text(
                  grup,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: AppColors.textSecondary,
                  ),
                ),
              ),
              ...controller.perGrup(grup).map(
                    (n) => _NotifikasiTile(notifikasi: n),
                  ),
              const SizedBox(height: 8),
            ],
          ],
        );
      }),
    );
  }
}

class _NotifikasiTile extends StatelessWidget {
  final Notifikasi notifikasi;

  const _NotifikasiTile({required this.notifikasi});

  IconData get _ikon => switch (notifikasi.jenis) {
        JenisNotifikasi.tugasBaru => Icons.assignment_outlined,
        JenisNotifikasi.penugasan => Icons.swap_horiz_outlined,
        JenisNotifikasi.selesai => Icons.check_circle_outline,
        JenisNotifikasi.ditolak => Icons.cancel_outlined,
        JenisNotifikasi.status => Icons.cleaning_services_outlined,
      };

  Color get _warna => switch (notifikasi.jenis) {
        JenisNotifikasi.tugasBaru => AppColors.info,
        JenisNotifikasi.penugasan => AppColors.warning,
        JenisNotifikasi.selesai => AppColors.success,
        JenisNotifikasi.ditolak => AppColors.danger,
        JenisNotifikasi.status => AppColors.primary,
      };

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: notifikasi.dibaca ? AppColors.border : AppColors.primary,
          width: notifikasi.dibaca ? 1 : 1.2,
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: _warna.withValues(alpha: 0.12),
              shape: BoxShape.circle,
            ),
            child: Icon(_ikon, size: 20, color: _warna),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        notifikasi.judul,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: notifikasi.dibaca
                              ? FontWeight.w500
                              : FontWeight.w700,
                        ),
                      ),
                    ),
                    Text(
                      notifikasi.waktu,
                      style: const TextStyle(
                        fontSize: 12,
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  notifikasi.isi,
                  style: const TextStyle(
                    fontSize: 13,
                    color: AppColors.textSecondary,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
          if (!notifikasi.dibaca)
            Container(
              width: 8,
              height: 8,
              margin: const EdgeInsets.only(left: 8, top: 6),
              decoration: const BoxDecoration(
                color: AppColors.primary,
                shape: BoxShape.circle,
              ),
            ),
        ],
      ),
    );
  }
}
