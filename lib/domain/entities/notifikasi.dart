enum JenisNotifikasi { tugasBaru, penugasan, selesai, ditolak, status }

class Notifikasi {
  final String judul;
  final String isi;
  final String waktu;
  final String grup;
  final bool dibaca;
  final JenisNotifikasi jenis;
  final String? tiket;

  const Notifikasi({
    required this.judul,
    required this.isi,
    required this.waktu,
    required this.grup,
    required this.dibaca,
    required this.jenis,
    this.tiket,
  });
}
