import 'package:flutter/material.dart';
import '../../../data/dummy_petugas.dart';
import '../../themes/app_colors.dart';
import '../auth/login_page.dart';

class PetugasProfilePage extends StatefulWidget {
  const PetugasProfilePage({super.key});
  @override
  State<PetugasProfilePage> createState() => _PetugasProfilePageState();
}

class _PetugasProfilePageState extends State<PetugasProfilePage> {
  bool _notificationOn = true;
  @override
  Widget build(BuildContext context) {
    final petugas = DummyPetugas.current;
    return Column(
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.fromLTRB(20, 26, 20, 28),
          decoration: const BoxDecoration(
            color: Color(0xFFFFC400),
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(42)),
          ),
          child: Column(
            children: [
              CircleAvatar(
                radius: 43,
                backgroundColor: AppColors.primary,
                child: Text(
                  petugas.nama.substring(0, 1),
                  style: const TextStyle(
                    color: AppColors.accent,
                    fontSize: 38,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
              const SizedBox(height: 12),
              Text(
                petugas.nama,
                style: const TextStyle(
                  color: AppColors.primary,
                  fontSize: 23,
                  fontWeight: FontWeight.w900,
                ),
              ),
              const SizedBox(height: 5),
              Text(
                '${petugas.jabatan}, Wilayah ${petugas.wilayah}',
                style: const TextStyle(color: Color(0xFF745D16), fontSize: 12),
              ),
            ],
          ),
        ),
        Expanded(
          child: ListView(
            padding: const EdgeInsets.fromLTRB(22, 22, 22, 16),
            children: [
              const Row(
                children: [
                  Expanded(
                    child: _ProfileStat(value: '86', label: 'Tugas selesai'),
                  ),
                  SizedBox(width: 14),
                  Expanded(
                    child: _ProfileStat(value: '42', label: 'Menit per tugas'),
                  ),
                ],
              ),
              const SizedBox(height: 22),
              _ProfileOption(
                title: 'Notifikasi tugas',
                trailing: Switch(
                  value: _notificationOn,
                  activeThumbColor: AppColors.accent,
                  activeTrackColor: AppColors.primary,
                  onChanged: (value) => setState(() => _notificationOn = value),
                ),
              ),
              _ProfileOption(
                title: 'Bantuan',
                onTap:
                    () => showDialog(
                      context: context,
                      builder:
                          (_) => AlertDialog(
                            title: const Text('Bantuan'),
                            content: const Text(
                              'Hubungi Pengelola jika mengalami kendala saat menjalankan tugas.',
                            ),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.pop(context),
                                child: const Text('Tutup'),
                              ),
                            ],
                          ),
                    ),
              ),
              _ProfileOption(
                title: 'Keluar',
                color: const Color(0xFFB33A32),
                onTap:
                    () => Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (_) => const LoginPage()),
                      (route) => false,
                    ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _ProfileStat extends StatelessWidget {
  final String value;
  final String label;
  const _ProfileStat({required this.value, required this.label});
  @override
  Widget build(BuildContext context) => Column(
    children: [
      Text(
        value,
        style: const TextStyle(
          color: AppColors.primary,
          fontSize: 36,
          fontWeight: FontWeight.w900,
        ),
      ),
      Text(
        label,
        style: const TextStyle(color: AppColors.textSecondary, fontSize: 12),
      ),
    ],
  );
}

class _ProfileOption extends StatelessWidget {
  final String title;
  final Widget? trailing;
  final VoidCallback? onTap;
  final Color color;
  const _ProfileOption({
    required this.title,
    this.trailing,
    this.onTap,
    this.color = AppColors.primary,
  });
  @override
  Widget build(BuildContext context) => InkWell(
    onTap: onTap,
    child: Container(
      height: 64,
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: Color(0xFFD8E4D2))),
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              title,
              style: TextStyle(
                color: color,
                fontSize: 14,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          if (trailing != null) trailing!,
        ],
      ),
    ),
  );
}