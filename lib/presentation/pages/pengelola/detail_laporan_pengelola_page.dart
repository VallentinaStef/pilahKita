import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/pengelola_controller.dart';
import '../../themes/app_colors.dart';
import '../../../domain/entities/laporan.dart';
import '../../../domain/entities/petugas.dart';

class DetailLaporanPengelolaPage extends StatefulWidget {
  final String tiket;

  const DetailLaporanPengelolaPage({super.key, required this.tiket});

  @override
  State<DetailLaporanPengelolaPage> createState() =>
      _DetailLaporanPengelolaPageState();
}

class _DetailLaporanPengelolaPageState
    extends State<DetailLaporanPengelolaPage> {
  late final PengelolaController controller;

  final TextEditingController alasanController = TextEditingController();

  Petugas? petugasDipilih;

  @override
  void initState() {
    super.initState();

    controller = Get.find<PengelolaController>();

    if (controller.petugasTersedia.isNotEmpty) {
      petugasDipilih = controller.petugasTersedia.first;
    }
  }

  @override
  void dispose() {
    alasanController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final laporan = controller.cariDetailLaporan(widget.tiket);

      if (laporan == null) {
        return Scaffold(
          backgroundColor: AppColors.background,
          body: const Center(child: Text('Laporan tidak ditemukan')),
        );
      }

      return Scaffold(
        backgroundColor: AppColors.background,
        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.only(bottom: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // PETA LOKASI
                _petaLokasi(),

                Padding(
                  padding: const EdgeInsets.fromLTRB(24, 12, 24, 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // NOMOR TIKET DAN STATUS
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            laporan.tiket,
                            style: const TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.w800,
                              color: AppColors.primary,
                            ),
                          ),
                          _statusChip(laporan.statusLabel, laporan.status),
                        ],
                      ),

                      const SizedBox(height: 12),

                      // INFORMASI LAPORAN
                      _informasiLaporan(laporan),

                      const SizedBox(height: 18),

                      // TAMPILAN SESUAI STATUS
                      ..._kontenBerdasarkanStatus(laporan),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }

  // =====================================================
  // PETA LOKASI
  // =====================================================

  Widget _petaLokasi() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: SizedBox(
          height: 140,
          width: double.infinity,
          child: Stack(
            children: [
              Positioned.fill(
                child: CustomPaint(painter: PetaLaporanPainter()),
              ),
              Positioned(
                top: 12,
                left: 12,
                child: CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: 17,
                  child: IconButton(
                    padding: EdgeInsets.zero,
                    iconSize: 18,
                    onPressed: () => Get.back(),
                    icon: const Icon(
                      Icons.arrow_back_ios_new,
                      color: AppColors.primary,
                    ),
                  ),
                ),
              ),
              const Positioned(
                bottom: 10,
                left: 12,
                child: Text(
                  'Lokasi laporan',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: AppColors.primary,
                    backgroundColor: Colors.white70,
                    fontSize: 11,
                  ),
                ),
              ),
              const Center(
                child: Icon(
                  Icons.location_on,
                  color: Color(0xFFC2410C),
                  size: 32,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // =====================================================
  // INFORMASI LAPORAN
  // =====================================================

  Widget _informasiLaporan(Laporan laporan) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Icon(Icons.location_on, color: AppColors.primary, size: 19),
        const SizedBox(width: 9),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                laporan.alamat,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  color: AppColors.primary,
                ),
              ),
              const SizedBox(height: 3),
              Text(
                '${laporan.jenisLabel}, volume ${laporan.volumeLabel}',
                style: const TextStyle(
                  fontSize: 11,
                  color: AppColors.textSecondary,
                ),
              ),
              const SizedBox(height: 3),
              Text(
                laporan.tanggal == null
                    ? 'Tanggal belum tersedia'
                    : 'Tanggal: ${laporan.tanggal!.day}/${laporan.tanggal!.month}/${laporan.tanggal!.year}',
                style: const TextStyle(
                  fontSize: 10,
                  color: AppColors.textSecondary,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // =====================================================
  // KONTEN BERDASARKAN STATUS
  // =====================================================

  List<Widget> _kontenBerdasarkanStatus(Laporan laporan) {
    switch (laporan.status) {
      case StatusLaporan.menunggu:
        return _tampilanMenunggu(laporan);

      case StatusLaporan.diproses:
        return _tampilanDiproses(laporan);

      case StatusLaporan.selesai:
        return _tampilanSelesai(laporan);

      case StatusLaporan.ditolak:
        return _tampilanDitolak(laporan);
    }
  }

  // =====================================================
  // 1. STATUS MENUNGGU
  // =====================================================

  List<Widget> _tampilanMenunggu(Laporan laporan) {
    return [
      Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(flex: 4, child: _fotoWarga(laporan.fotoWarga)),
          const SizedBox(width: 10),
          Expanded(flex: 7, child: _pilihPetugas()),
        ],
      ),

      const SizedBox(height: 16),

      const Text(
        'Alasan jika ditolak',
        style: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.bold,
          color: AppColors.primary,
        ),
      ),

      const SizedBox(height: 7),

      TextField(
        controller: alasanController,
        maxLines: 2,
        style: const TextStyle(fontSize: 12),
        decoration: const InputDecoration(
          hintText: 'Masukkan alasan penolakan',
          hintStyle: TextStyle(fontSize: 12),
          contentPadding: EdgeInsets.symmetric(horizontal: 2, vertical: 8),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: AppColors.primary),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: AppColors.primary, width: 2),
          ),
        ),
      ),

      const SizedBox(height: 14),

      // TERIMA LAPORAN
      SizedBox(
        width: double.infinity,
        height: 50,
        child: ElevatedButton(
          onPressed:
              petugasDipilih == null
                  ? null
                  : () {
                    final petugas = petugasDipilih!;

                    controller.terimaLaporan(widget.tiket, petugas);

                    Get.snackbar(
                      'Laporan diterima',
                      'Ditugaskan kepada ${petugas.nama}',
                      snackPosition: SnackPosition.BOTTOM,
                    );
                  },
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primary,
            foregroundColor: Colors.white,
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(22),
            ),
          ),
          child: const Text(
            'Terima dan Tugaskan',
            style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
          ),
        ),
      ),

      const SizedBox(height: 8),

      // TOLAK LAPORAN
      SizedBox(
        width: double.infinity,
        height: 46,
        child: OutlinedButton(
          onPressed: _tolakLaporan,
          style: OutlinedButton.styleFrom(
            foregroundColor: AppColors.danger,
            side: const BorderSide(color: AppColors.danger, width: 1.5),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18),
            ),
          ),
          child: const Text(
            'Tolak Laporan',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
          ),
        ),
      ),
    ];
  }

  // =====================================================
  // 2. STATUS DIPROSES
  // =====================================================

  List<Widget> _tampilanDiproses(Laporan laporan) {
    return [
      const Text(
        'Foto Laporan Warga',
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.bold,
          color: AppColors.primary,
        ),
      ),

      const SizedBox(height: 8),

      _fotoWarga(laporan.fotoWarga),

      const SizedBox(height: 14),

      _infoPetugas(laporan.petugas),

      const SizedBox(height: 12),

      SizedBox(
        width: double.infinity,
        height: 48,
        child: OutlinedButton(
          onPressed: _dialogTugaskanUlang,
          style: OutlinedButton.styleFrom(
            foregroundColor: AppColors.primary,
            side: const BorderSide(color: AppColors.primary),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18),
            ),
          ),
          child: const Text(
            'Tugaskan Ulang',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
          ),
        ),
      ),
    ];
  }

  // =====================================================
  // 3. STATUS SELESAI
  // =====================================================

  List<Widget> _tampilanSelesai(Laporan laporan) {
    return [
      const Text(
        'Bukti Pembersihan',
        style: TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.bold,
          color: AppColors.primary,
        ),
      ),

      const SizedBox(height: 10),

      Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(child: _fotoBukti('Sebelum', laporan.fotoSebelum)),
          const SizedBox(width: 10),
          Expanded(child: _fotoBukti('Sesudah', laporan.fotoSesudah)),
        ],
      ),

      const SizedBox(height: 16),

      _infoPetugas(laporan.petugas),

      const SizedBox(height: 10),

      Text(
        'Waktu selesai: ${_waktuSelesai(laporan)}',
        style: const TextStyle(fontSize: 11, color: AppColors.textSecondary),
      ),

      const SizedBox(height: 12),

      const Text(
        'Riwayat Status',
        style: TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.bold,
          color: AppColors.primary,
        ),
      ),

      const SizedBox(height: 10),

      ...laporan.timeline.map((item) => _itemTimeline(item)),
    ];
  }

  // =====================================================
  // 4. STATUS DITOLAK
  // =====================================================

  List<Widget> _tampilanDitolak(Laporan laporan) {
    return [
      const Text(
        'Foto Laporan Warga',
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.bold,
          color: AppColors.primary,
        ),
      ),

      const SizedBox(height: 8),

      _fotoWarga(laporan.fotoWarga),

      const SizedBox(height: 16),

      const Text(
        'Alasan Penolakan',
        style: TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.bold,
          color: AppColors.danger,
        ),
      ),

      const SizedBox(height: 8),

      Container(
        width: double.infinity,
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Text(
          laporan.alasanPenolakan ?? 'Tidak ada alasan penolakan.',
          style: const TextStyle(fontSize: 12, color: AppColors.textPrimary),
        ),
      ),
    ];
  }

  // =====================================================
  // PILIH PETUGAS
  // =====================================================

  Widget _pilihPetugas() {
    final petugas = controller.petugasTersedia;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Tugaskan ke:',
          style: TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.bold,
            color: AppColors.primary,
          ),
        ),

        const SizedBox(height: 7),

        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            for (final item in petugas)
              GestureDetector(
                onTap: () {
                  setState(() {
                    petugasDipilih = item;
                  });
                },
                child: CircleAvatar(
                  radius: 20,
                  backgroundColor:
                      petugasDipilih?.id == item.id
                          ? AppColors.accent
                          : const Color(0xFFA8D7DF),
                  child: Text(
                    item.nama.substring(0, 1).toUpperCase(),
                    style: const TextStyle(
                      color: AppColors.primary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
          ],
        ),

        const SizedBox(height: 5),

        Text(
          petugasDipilih?.nama ?? 'Belum ada petugas dipilih',
          style: const TextStyle(fontSize: 10, color: AppColors.textSecondary),
        ),
      ],
    );
  }

  // =====================================================
  // FOTO WARGA
  // =====================================================

  Widget _fotoWarga(String? path) {
    return Container(
      height: 100,
      width: double.infinity,
      decoration: BoxDecoration(
        color: const Color(0xFFD7E8CE),
        border: Border.all(color: Colors.white, width: 4),
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.10),
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      clipBehavior: Clip.antiAlias,
      child:
          path == null
              ? const Center(
                child: Text('Foto warga', style: TextStyle(fontSize: 11)),
              )
              : Image.asset(
                path,
                fit: BoxFit.cover,
                errorBuilder:
                    (_, __, ___) =>
                        const Center(child: Text('Foto tidak tersedia')),
              ),
    );
  }

  // =====================================================
  // FOTO SEBELUM DAN SESUDAH
  // =====================================================

  Widget _fotoBukti(String judul, String? path) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          judul,
          style: const TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.bold,
            color: AppColors.primary,
          ),
        ),

        const SizedBox(height: 6),

        Container(
          height: 110,
          width: double.infinity,
          decoration: BoxDecoration(
            color: const Color(0xFFD7E8CE),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.white, width: 3),
          ),
          clipBehavior: Clip.antiAlias,
          child:
              path == null
                  ? Center(child: Text('Foto $judul'))
                  : Image.asset(
                    path,
                    fit: BoxFit.cover,
                    errorBuilder:
                        (_, __, ___) =>
                            Center(child: Text('Foto $judul tidak tersedia')),
                  ),
        ),
      ],
    );
  }

  // =====================================================
  // INFORMASI PETUGAS
  // =====================================================

  Widget _infoPetugas(String? nama) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(13),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Row(
        children: [
          const CircleAvatar(
            radius: 20,
            backgroundColor: AppColors.accent,
            child: Icon(Icons.person, color: AppColors.primary),
          ),

          const SizedBox(width: 10),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  nama ?? 'Belum ada petugas',
                  style: const TextStyle(
                    color: AppColors.primary,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
                const Text(
                  'Petugas kebersihan',
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
    );
  }

  // =====================================================
  // TIMELINE
  // =====================================================

  Widget _itemTimeline(LangkahStatus item) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            item.tercapai ? Icons.check_circle : Icons.radio_button_unchecked,
            color: item.tercapai ? AppColors.success : AppColors.textSecondary,
            size: 17,
          ),

          const SizedBox(width: 9),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.judul,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: AppColors.primary,
                  ),
                ),
                Text(
                  item.waktu,
                  style: const TextStyle(
                    fontSize: 10,
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

  // =====================================================
  // STATUS CHIP
  // =====================================================

  Widget _statusChip(String label, StatusLaporan status) {
    final warna = switch (status) {
      StatusLaporan.menunggu => AppColors.warning,
      StatusLaporan.diproses => AppColors.processing,
      StatusLaporan.selesai => AppColors.success,
      StatusLaporan.ditolak => AppColors.danger,
    };

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 5),
      decoration: BoxDecoration(
        border: Border.all(color: warna),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: warna,
          fontSize: 9,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  // =====================================================
  // TUGASKAN ULANG
  // =====================================================

  void _dialogTugaskanUlang() {
    final petugas = controller.petugasTersedia;

    if (petugas.isEmpty) {
      Get.snackbar('Petugas kosong', 'Belum ada petugas tersedia.');
      return;
    }

    Petugas? terpilih = petugas.first;

    Get.dialog(
      StatefulBuilder(
        builder: (context, setDialogState) {
          return AlertDialog(
            title: const Text('Tugaskan Ulang'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                for (final item in petugas)
                  RadioListTile<Petugas>(
                    contentPadding: EdgeInsets.zero,
                    title: Text(item.nama),
                    subtitle: Text(item.wilayah),
                    value: item,
                    groupValue: terpilih,
                    onChanged: (value) {
                      setDialogState(() {
                        terpilih = value;
                      });
                    },
                  ),
              ],
            ),
            actions: [
              TextButton(onPressed: Get.back, child: const Text('Batal')),
              ElevatedButton(
                onPressed: () {
                  if (terpilih == null) return;

                  controller.tugaskanUlang(widget.tiket, terpilih!);

                  Get.back();

                  Get.snackbar(
                    'Penugasan diperbarui',
                    'Ditugaskan kepada ${terpilih!.nama}',
                  );
                },
                child: const Text('Simpan'),
              ),
            ],
          );
        },
      ),
    );
  }

  // =====================================================
  // TOLAK LAPORAN
  // =====================================================

  void _tolakLaporan() {
    if (alasanController.text.trim().isEmpty) {
      Get.snackbar(
        'Alasan wajib diisi',
        'Masukkan alasan penolakan terlebih dahulu.',
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    controller.tolakLaporan(widget.tiket, alasanController.text.trim());

    Get.snackbar(
      'Laporan ditolak',
      'Alasan penolakan berhasil disimpan.',
      snackPosition: SnackPosition.BOTTOM,
    );
  }

  // =====================================================
  // WAKTU SELESAI
  // =====================================================

  String _waktuSelesai(Laporan laporan) {
    final selesai = laporan.timeline.where(
      (item) => item.judul.toLowerCase() == 'selesai' && item.tercapai,
    );

    return selesai.isEmpty ? 'Waktu belum tersedia' : selesai.last.waktu;
  }
}

// =======================================================
// PETA ILUSTRASI SEMENTARA
// =======================================================

class PetaLaporanPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final bg = Paint()..color = const Color(0xFFDDEED3);

    canvas.drawRect(Offset.zero & size, bg);

    final area = Paint()..color = const Color(0xFFBFE0AC);

    canvas.drawOval(Rect.fromLTWH(10, 8, 110, 55), area);

    canvas.drawOval(Rect.fromLTWH(size.width - 115, 75, 130, 65), area);

    final jalan =
        Paint()
          ..color = Colors.white
          ..strokeWidth = 8
          ..strokeCap = StrokeCap.round;

    canvas.drawLine(
      Offset(size.width * .30, -10),
      Offset(size.width * .53, size.height + 10),
      jalan,
    );

    canvas.drawLine(
      Offset(size.width * .76, -10),
      Offset(size.width * .68, size.height + 10),
      jalan,
    );

    canvas.drawLine(
      Offset(-10, size.height * .55),
      Offset(size.width + 10, size.height * .32),
      jalan,
    );

    final sungai =
        Paint()
          ..color = const Color(0xFF9ED6E7)
          ..strokeWidth = 13
          ..strokeCap = StrokeCap.round
          ..style = PaintingStyle.stroke;

    final path =
        Path()
          ..moveTo(-5, size.height * .70)
          ..quadraticBezierTo(
            size.width * .40,
            size.height * .35,
            size.width + 5,
            size.height * .48,
          );

    canvas.drawPath(path, sungai);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
