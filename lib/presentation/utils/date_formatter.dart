class DateFormatter {
  DateFormatter._();

  static const _bulan = [
    'Jan',
    'Feb',
    'Mar',
    'Apr',
    'Mei',
    'Jun',
    'Jul',
    'Agu',
    'Sep',
    'Okt',
    'Nov',
    'Des',
  ];

  static String tanggalPendek(DateTime date) {
    return '${date.day} ${_bulan[date.month - 1]}';
  }

  static String tanggalLengkap(DateTime date) {
    return '${date.day} ${_bulan[date.month - 1]} ${date.year}';
  }

  static String jam(DateTime date) {
    final h = date.hour.toString().padLeft(2, '0');
    final m = date.minute.toString().padLeft(2, '0');
    return '$h.$m';
  }

  static String tanggalDanJam(DateTime date) {
    return '${tanggalPendek(date)}, ${jam(date)}';
  }
}
