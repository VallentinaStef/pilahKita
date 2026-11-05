class Petugas {
  final String id;
  final String nama;
  final String email;
  final String nomorTelepon;
  final String jabatan;
  final String wilayah;

  const Petugas({
    required this.id,
    required this.nama,
    required this.email,
    required this.nomorTelepon,
    required this.jabatan,
    required this.wilayah,
  });

  Petugas copyWith({
    String? id,
    String? nama,
    String? email,
    String? nomorTelepon,
    String? jabatan,
    String? wilayah,
  }) {
    return Petugas(
      id: id ?? this.id,
      nama: nama ?? this.nama,
      email: email ?? this.email,
      nomorTelepon: nomorTelepon ?? this.nomorTelepon,
      jabatan: jabatan ?? this.jabatan,
      wilayah: wilayah ?? this.wilayah,
    );
  }
}
