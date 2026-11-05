import 'package:flutter/material.dart';
import '../../../data/dummy_data.dart';
import '../../../domain/entities/notifikasi.dart';
import '../../themes/app_colors.dart';

class PetugasNotificationsPage extends StatefulWidget {
  const PetugasNotificationsPage({super.key});
  @override
  State<PetugasNotificationsPage> createState() =>
      _PetugasNotificationsPageState();
}

class _PetugasNotificationsPageState extends State<PetugasNotificationsPage> {
  late List<bool> _read;
  @override
  void initState() {
    super.initState();
    _read = DummyData.notifikasiPetugas.map((n) => n.dibaca).toList();
  }

  int get _unread => _read.where((read) => !read).length;
  @override
  Widget build(BuildContext context) {
    final items = DummyData.notifikasiPetugas;
    return Column(
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.fromLTRB(22, 27, 22, 22),
          decoration: const BoxDecoration(
            color: Color(0xFFFFC400),
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(34)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Notifikasi',
                style: TextStyle(
                  color: AppColors.primary,
                  fontSize: 26,
                  fontWeight: FontWeight.w900,
                ),
              ),
              const SizedBox(height: 5),
              Text(
                '$_unread belum dibaca',
                style: const TextStyle(color: Color(0xFF745D16), fontSize: 12),
              ),
            ],
          ),
        ),
        Expanded(
          child: ListView(
            padding: const EdgeInsets.fromLTRB(18, 12, 18, 18),
            children: List.generate(
              items.length,
              (index) => _NotificationRow(
                item: items[index],
                read: _read[index],
                onTap: () => setState(() => _read[index] = true),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _NotificationRow extends StatelessWidget {
  final Notifikasi item;
  final bool read;
  final VoidCallback onTap;
  const _NotificationRow({
    required this.item,
    required this.read,
    required this.onTap,
  });
  @override
  Widget build(BuildContext context) {
    final color =
        item.jenis == JenisNotifikasi.selesai
            ? const Color(0xFF00A66A)
            : item.jenis == JenisNotifikasi.penugasan
            ? const Color(0xFFFFC400)
            : const Color(0xFF8B5A2B);
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 13),
        decoration: const BoxDecoration(
          border: Border(bottom: BorderSide(color: Color(0xFFD8E4D2))),
        ),
        child: Row(
          children: [
            Container(
              width: 47,
              height: 47,
              decoration: BoxDecoration(
                color: const Color(0xFFD9EAF0),
                borderRadius: BorderRadius.circular(25),
              ),
              child: Icon(Icons.delete, color: color, size: 25),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.judul,
                    style: const TextStyle(
                      color: AppColors.primary,
                      fontSize: 12,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    '${item.isi} ${item.waktu}',
                    style: const TextStyle(
                      color: AppColors.textSecondary,
                      fontSize: 11,
                      height: 1.3,
                    ),
                  ),
                ],
              ),
            ),
            if (!read)
              Container(
                width: 9,
                height: 9,
                margin: const EdgeInsets.only(left: 8),
                decoration: const BoxDecoration(
                  color: Color(0xFFC94B22),
                  shape: BoxShape.circle,
                ),
              ),
          ],
        ),
      ),
    );
  }
}