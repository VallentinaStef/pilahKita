enum StatusLaporan { menunggu, diproses, selesai, ditolak }

enum JenisSampah { organik, anorganik, campuran }

enum VolumeSampah { kecil, sedang, besar }

class LangkahStatus {
  final String judul;
  final String waktu;
  final bool tercapai;

  const LangkahStatus({
    required this.judul,
    required this.waktu,
    required this.tercapai,
  });
}

class Laporan {
  final String tiket;
  final StatusLaporan status;
  final String alamat;
  final JenisSampah jenisSampah;
  final VolumeSampah volume;
  final String? petugas;
  final String? alasanPenolakan;
  final String? fotoWarga;
  final String? fotoSebelum;
  final String? fotoSesudah;
  final List<LangkahStatus> timeline;

  const Laporan({
    required this.tiket,
    required this.status,
    required this.alamat,
    required this.jenisSampah,
    required this.volume,
    this.petugas,
    this.alasanPenolakan,
    this.fotoWarga,
    this.fotoSebelum,
    this.fotoSesudah,
    this.timeline = const [],
  });

  String get jenisLabel => switch (jenisSampah) {
        JenisSampah.organik => 'Organik',
        JenisSampah.anorganik => 'Anorganik',
        JenisSampah.campuran => 'Campuran',
      };

  String get volumeLabel => switch (volume) {
        VolumeSampah.kecil => 'kecil',
        VolumeSampah.sedang => 'sedang',
        VolumeSampah.besar => 'besar',
      };

  String get statusLabel => switch (status) {
        StatusLaporan.menunggu => 'Menunggu validasi',
        StatusLaporan.diproses => 'Dalam proses',
        StatusLaporan.selesai => 'Selesai',
        StatusLaporan.ditolak => 'Ditolak',
      };

  String get ringkasan => '$jenisLabel, volume $volumeLabel';
}
