import 'package:excel/excel.dart';

import '../../domain/entities/laporan.dart';
import 'save_exported_excel.dart';

class ExportLaporanExcel {
  ExportLaporanExcel._();

  static Future<void> export({
    required List<Laporan> laporan,
    required String periode,
  }) async {
    if (laporan.isEmpty) {
      throw Exception('Tidak ada laporan untuk diekspor.');
    }

    final excel = Excel.createExcel();
    final sheet = excel['Rekap Laporan'];

    // Judul
    sheet.appendRow([TextCellValue('REKAPITULASI LAPORAN PILAHKITA')]);

    sheet.appendRow([TextCellValue('Periode: $periode')]);

    sheet.appendRow([]);

    // Header tabel
    sheet.appendRow([
      TextCellValue('No'),
      TextCellValue('Nomor Tiket'),
      TextCellValue('Tanggal'),
      TextCellValue('Alamat'),
      TextCellValue('Jenis Sampah'),
      TextCellValue('Volume'),
      TextCellValue('Status'),
      TextCellValue('Petugas'),
      TextCellValue('Alasan Penolakan'),
    ]);

    // Data laporan
    for (int i = 0; i < laporan.length; i++) {
      final item = laporan[i];

      final tanggal =
          item.tanggal == null
              ? '-'
              : '${item.tanggal!.day}/'
                  '${item.tanggal!.month}/'
                  '${item.tanggal!.year}';

      sheet.appendRow([
        IntCellValue(i + 1),
        TextCellValue(item.tiket),
        TextCellValue(tanggal),
        TextCellValue(item.alamat),
        TextCellValue(item.jenisLabel),
        TextCellValue(item.volumeLabel),
        TextCellValue(item.statusLabel),
        TextCellValue(item.petugas ?? '-'),
        TextCellValue(item.alasanPenolakan ?? '-'),
      ]);
    }

    // Encode Excel
    final bytes = excel.encode();

    if (bytes == null) {
      throw Exception('Gagal membuat file Excel.');
    }

    await saveExcelFile(
      bytes,
      'Rekap_PilahKita_${DateTime.now().millisecondsSinceEpoch}.xlsx',
    );
  }
}
