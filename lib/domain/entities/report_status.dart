// Baru satu status yang dipakai. Status lain (dalam proses, selesai)
// ditambah saat halaman peta pengelola (2.7) dikerjakan.
enum ReportStatus {
  menungguValidasi('Menunggu validasi');

  final String label;
  const ReportStatus(this.label);
}
