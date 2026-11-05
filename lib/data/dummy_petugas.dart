import '../domain/entities/petugas.dart';

class DummyPetugas {
  DummyPetugas._();

  static const Petugas current = Petugas(
    id: 'PTG-001',
    nama: 'Dedi Kurniawan',
    email: 'dedi@pilahkita.id',
    nomorTelepon: '0812-3456-7890',
    jabatan: 'Petugas Kebersihan',
    wilayah: 'Coblong, Bandung',
  );

  static const List<Petugas> daftar = [
    current,
    Petugas(
      id: 'PTG-002',
      nama: 'Yusuf Pratama',
      email: 'yusuf@pilahkita.id',
      nomorTelepon: '0813-4567-8901',
      jabatan: 'Petugas Kebersihan',
      wilayah: 'Cihampelas, Bandung',
    ),
  ];
}