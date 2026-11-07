import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pilahkita/presentation/pages/report-making/report_page.dart';

import '../themes/app_colors.dart';
import '../../domain/entities/laporan.dart';
import '../controllers/laporan_controller.dart';
import '../widgets/status_chip.dart';
import 'report-making/report_page.dart';

class DetailLaporanPage extends StatefulWidget {
  final String tiket;

  const DetailLaporanPage({super.key, required this.tiket});

  @override
  State<DetailLaporanPage> createState() => _DetailLaporanPageState();
}

class _DetailLaporanPageState extends State<DetailLaporanPage> {
  late final LaporanController _controller;

  @override
  void initState() {
    super.initState();
    _controller = Get.find<LaporanController>();
    _controller.muatDetail(widget.tiket);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Obx(() {
        final laporan = _controller.detailLaporan.value;
        if (_controller.isLoadingDetail.value || laporan == null) {
          return const Center(child: CircularProgressIndicator());
        }
        return Column(
          children: [
            _Header(laporan: laporan),
            Expanded(
              child: switch (laporan.status) {
                StatusLaporan.diproses => _DetailBerjalan(laporan: laporan),
                StatusLaporan.ditolak => _DetailDitolak(laporan: laporan),
                StatusLaporan.selesai => _DetailSelesai(laporan: laporan),
                StatusLaporan.menunggu => _DetailMenunggu(laporan: laporan),
              },
            ),
          ],
        );
      }),
    );
  }
}

class _Header extends StatelessWidget {
  final Laporan laporan;

  const _Header({required this.laporan});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.primary,
      child: SafeArea(
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(4, 8, 16, 20),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.white),
                onPressed: () => Navigator.maybePop(context),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Tiket',
                      style: TextStyle(color: Colors.white70, fontSize: 12),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      laporan.tiket,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 28,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    if (laporan.status == StatusLaporan.ditolak &&
                        laporan.timeline.isNotEmpty) ...[
                      const SizedBox(height: 4),
                      Text(
                        'Dikirim ${laporan.timeline.first.waktu}',
                        style: const TextStyle(
                          color: Colors.white70,
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 14),
                child: StatusChip(status: laporan.status),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _LokasiCard extends StatelessWidget {
  final Laporan laporan;

  const _LokasiCard({required this.laporan});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(
            Icons.delete_outline,
            size: 20,
            color: AppColors.textPrimary,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  laporan.alamat,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  laporan.ringkasan,
                  style: const TextStyle(
                    fontSize: 13,
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _Timeline extends StatelessWidget {
  final List<LangkahStatus> steps;

  const _Timeline({required this.steps});

  @override
  Widget build(BuildContext context) {
    var aktifIndex = -1;
    for (var i = 0; i < steps.length; i++) {
      if (steps[i].tercapai) aktifIndex = i;
    }

    return Column(
      children: [
        for (var i = 0; i < steps.length; i++)
          IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  children: [
                    _Dot(
                      state:
                          !steps[i].tercapai
                              ? _DotState.pending
                              : i == aktifIndex
                              ? _DotState.aktif
                              : _DotState.selesai,
                    ),
                    if (i != steps.length - 1)
                      Expanded(
                        child: Container(
                          width: 2,
                          color:
                              steps[i].tercapai && steps[i + 1].tercapai
                                  ? AppColors.primary
                                  : AppColors.border,
                        ),
                      ),
                  ],
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(
                      bottom: i == steps.length - 1 ? 0 : 22,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          steps[i].judul,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color:
                                steps[i].tercapai
                                    ? AppColors.textPrimary
                                    : AppColors.textSecondary,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          steps[i].waktu,
                          style: const TextStyle(
                            fontSize: 12,
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ],
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

enum _DotState { selesai, aktif, pending }

class _Dot extends StatelessWidget {
  final _DotState state;

  const _Dot({required this.state});

  @override
  Widget build(BuildContext context) {
    final color = switch (state) {
      _DotState.selesai => AppColors.primary,
      _DotState.aktif => AppColors.processing,
      _DotState.pending => Colors.transparent,
    };
    return Container(
      width: 22,
      height: 22,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color,
        border:
            state == _DotState.pending
                ? Border.all(color: AppColors.border, width: 2)
                : null,
      ),
      child:
          state == _DotState.selesai
              ? const Icon(Icons.check, size: 14, color: Colors.white)
              : null,
    );
  }
}

class _FotoPlaceholder extends StatelessWidget {
  final String label;

  const _FotoPlaceholder({required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 170,
      width: double.infinity,
      decoration: BoxDecoration(
        color: const Color(0xFFE2F3E8),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Center(
        child: Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: AppColors.textPrimary,
          ),
        ),
      ),
    );
  }
}

class _DetailBerjalan extends StatelessWidget {
  final Laporan laporan;

  const _DetailBerjalan({required this.laporan});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.fromLTRB(16, 20, 16, 24),
      children: [
        if (laporan.petugas != null)
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(14),
            ),
            child: Text(
              '${laporan.petugas} sedang membersihkan lokasimu.',
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
            ),
          ),
        const SizedBox(height: 24),
        if (laporan.timeline.isNotEmpty) ...[
          _Timeline(steps: laporan.timeline),
          const SizedBox(height: 24),
        ],
        _LokasiCard(laporan: laporan),
      ],
    );
  }
}

class _DetailDitolak extends StatelessWidget {
  final Laporan laporan;

  const _DetailDitolak({required this.laporan});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView(
            padding: const EdgeInsets.fromLTRB(16, 20, 16, 16),
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.rejectBackground,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Alasan penolakan',
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        color: AppColors.danger,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      laporan.alasanPenolakan ?? '-',
                      style: const TextStyle(fontSize: 13, height: 1.5),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              const _FotoPlaceholder(label: 'Foto kamu'),
              const SizedBox(height: 16),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(
                    Icons.delete_outline,
                    size: 18,
                    color: AppColors.textPrimary,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      '${laporan.alamat}. ${laporan.ringkasan}',
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        SafeArea(
          top: false,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 4, 16, 16),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const ReportPage()),
                  );
                },
                child: const Text('Buat laporan baru'),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _DetailSelesai extends StatelessWidget {
  final Laporan laporan;

  const _DetailSelesai({required this.laporan});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.fromLTRB(16, 20, 16, 24),
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(14),
          ),
          child: Row(
            children: [
              const Icon(
                Icons.check_circle_outline,
                color: AppColors.success,
                size: 22,
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  'Dibersihkan oleh ${laporan.petugas ?? "petugas"}',
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        const Row(
          children: [
            Expanded(child: _FotoPlaceholder(label: 'Sebelum')),
            SizedBox(width: 12),
            Expanded(child: _FotoPlaceholder(label: 'Sesudah')),
          ],
        ),
        const SizedBox(height: 24),
        _LokasiCard(laporan: laporan),
        const SizedBox(height: 16),
        Container(
          height: 170,
          width: double.infinity,
          decoration: BoxDecoration(
            color: const Color(0xFFE2F3E8),
            borderRadius: BorderRadius.circular(10),
          ),
          child: const Center(
            child: Text(
              'Maps',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: AppColors.textPrimary,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _DetailMenunggu extends StatelessWidget {
  final Laporan laporan;

  const _DetailMenunggu({required this.laporan});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.fromLTRB(16, 20, 16, 24),
      children: [
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(14),
          ),
          child: const Column(
            children: [
              Icon(
                Icons.hourglass_top_outlined,
                size: 40,
                color: AppColors.warning,
              ),
              SizedBox(height: 12),
              Text(
                'Menunggu validasi',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
              ),
              SizedBox(height: 6),
              Text(
                'Pengelola akan memeriksa laporanmu. Kamu akan dapat kabar saat statusnya berubah.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 13,
                  color: AppColors.textSecondary,
                  height: 1.5,
                ),
              ),
            ],
          ),
        ),
        if (laporan.timeline.isNotEmpty) ...[
          const SizedBox(height: 24),
          _Timeline(steps: laporan.timeline),
        ],
        const SizedBox(height: 24),
        _LokasiCard(laporan: laporan),
      ],
    );
  }
}
