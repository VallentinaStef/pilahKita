import '../domain/entities/laporan.dart';
import '../domain/entities/notifikasi.dart';

class DummyData {
  DummyData._();

  static final List<Laporan> laporan = [
    const Laporan(
      tiket: 'PK-0412',
      status: StatusLaporan.diproses,
      alamat: 'Jl. Dipatiukur No. 35',
      jenisSampah: JenisSampah.anorganik,
      volume: VolumeSampah.besar,
      petugas: 'Pak Dedi',
      fotoWarga: 'assets/foto_warga_pk0412.jpg',
      timeline: [
        LangkahStatus(
            judul: 'Laporan dikirim', waktu: '29 Okt, 08.12', tercapai: true),
        LangkahStatus(
            judul: 'Ditugaskan ke Pak Dedi',
            waktu: '29 Okt, 10.40',
            tercapai: true),
        LangkahStatus(
            judul: 'Sedang dibersihkan',
            waktu: '30 Okt, 07.55',
            tercapai: true),
        LangkahStatus(
            judul: 'Selesai', waktu: 'Menunggu foto bukti', tercapai: false),
      ],
    ),
    const Laporan(
      tiket: 'PK-0409',
      status: StatusLaporan.menunggu,
      alamat: 'Tepi Sungai Cikapundung',
      jenisSampah: JenisSampah.campuran,
      volume: VolumeSampah.sedang,
      timeline: [
        LangkahStatus(
            judul: 'Laporan dikirim', waktu: '29 Okt, 06.30', tercapai: true),
        LangkahStatus(
            judul: 'Menunggu validasi',
            waktu: 'Sedang diperiksa Pengelola',
            tercapai: false),
      ],
    ),
    const Laporan(
      tiket: 'PK-0398',
      status: StatusLaporan.selesai,
      alamat: 'Pasar Kosambi',
      jenisSampah: JenisSampah.organik,
      volume: VolumeSampah.kecil,
      petugas: 'Pak Dedi',
      fotoSebelum: 'assets/foto_sebelum_pk0398.jpg',
      fotoSesudah: 'assets/foto_sesudah_pk0398.jpg',
      timeline: [
        LangkahStatus(
            judul: 'Laporan dikirim', waktu: '27 Okt, 14.20', tercapai: true),
        LangkahStatus(
            judul: 'Ditugaskan ke Pak Dedi',
            waktu: '27 Okt, 15.05',
            tercapai: true),
        LangkahStatus(
            judul: 'Sedang dibersihkan',
            waktu: '28 Okt, 15.40',
            tercapai: true),
        LangkahStatus(
            judul: 'Selesai', waktu: '28 Okt, 16.02', tercapai: true),
      ],
    ),
    const Laporan(
      tiket: 'PK-0390',
      status: StatusLaporan.ditolak,
      alamat: 'Jl. Riau No. 40',
      jenisSampah: JenisSampah.anorganik,
      volume: VolumeSampah.kecil,
      alasanPenolakan:
          'Foto tidak menunjukkan sampah. Ambil foto yang lebih dekat dan jelas.',
      fotoWarga: 'assets/foto_warga_pk0390.jpg',
      timeline: [
        LangkahStatus(
            judul: 'Laporan dikirim', waktu: '26 Okt, 09.12', tercapai: true),
        LangkahStatus(
            judul: 'Ditolak Pengelola', waktu: '26 Okt, 09.40', tercapai: true),
      ],
    ),
    const Laporan(
      tiket: 'PK-0421',
      status: StatusLaporan.menunggu,
      alamat: 'Jl. Dipatiukur No. 35',
      jenisSampah: JenisSampah.anorganik,
      volume: VolumeSampah.besar,
      timeline: [
        LangkahStatus(
            judul: 'Laporan dikirim', waktu: 'Hari ini, 08.12', tercapai: true),
        LangkahStatus(
            judul: 'Menunggu validasi',
            waktu: 'Sedang diperiksa Pengelola',
            tercapai: false),
      ],
    ),
  ];

  static final List<Notifikasi> notifikasiWarga = [
    const Notifikasi(
      judul: 'PK-0412 sedang dibersihkan',
      isi: 'Pak Dedi sudah di lokasi.',
      waktu: '07.55',
      grup: 'Hari ini',
      dibaca: false,
      jenis: JenisNotifikasi.status,
    ),
    const Notifikasi(
      judul: 'PK-0409 sudah ditugaskan',
      isi: 'Petugas akan segera menuju lokasi.',
      waktu: '06.30',
      grup: 'Hari ini',
      dibaca: false,
      jenis: JenisNotifikasi.penugasan,
    ),
    const Notifikasi(
      judul: 'PK-0398 selesai',
      isi: 'Lihat foto bukti pembersihan.',
      waktu: '16.10',
      grup: 'Kemarin',
      dibaca: true,
      jenis: JenisNotifikasi.selesai,
    ),
    const Notifikasi(
      judul: 'PK-0390 ditolak',
      isi: 'Alasan: foto tidak menunjukkan sampah.',
      waktu: '09.12',
      grup: 'Kemarin',
      dibaca: true,
      jenis: JenisNotifikasi.ditolak,
    ),
  ];

  static final List<Notifikasi> notifikasiPetugas = [
    const Notifikasi(
      judul: 'Tugas baru PK-0417',
      isi: 'Taman Lansia, organik kecil.',
      waktu: '07.10',
      grup: 'Hari ini',
      dibaca: false,
      jenis: JenisNotifikasi.tugasBaru,
    ),
    const Notifikasi(
      judul: 'Tugas baru PK-0415',
      isi: 'Jl. Cihampelas No. 8.',
      waktu: '06.50',
      grup: 'Hari ini',
      dibaca: false,
      jenis: JenisNotifikasi.tugasBaru,
    ),
    const Notifikasi(
      judul: 'PK-0409 dipindahkan ke Rina',
      isi: 'Penugasan ulang oleh Pengelola.',
      waktu: 'Kemarin',
      grup: 'Kemarin',
      dibaca: true,
      jenis: JenisNotifikasi.penugasan,
    ),
    const Notifikasi(
      judul: 'PK-0398 tercatat selesai',
      isi: 'Foto bukti diterima.',
      waktu: 'Kemarin',
      grup: 'Kemarin',
      dibaca: true,
      jenis: JenisNotifikasi.selesai,
    ),
  ];
}
