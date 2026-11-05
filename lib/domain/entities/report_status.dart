enum ReportStatus {
  menungguValidasi('Menunggu validasi'),
  dalamProses('Dalam proses'),
  selesai('Selesai');

  final String label;
  const ReportStatus(this.label);
}
