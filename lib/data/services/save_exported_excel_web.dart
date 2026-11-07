// ignore_for_file: avoid_web_libraries_in_flutter, deprecated_member_use

import 'dart:html' as html;

Future<void> saveExcelFile(List<int> bytes, String filename) async {
  final blob = html.Blob([
    bytes,
  ], 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet');
  final url = html.Url.createObjectUrlFromBlob(blob);

  try {
    html.AnchorElement(href: url)
      ..setAttribute('download', filename)
      ..click();
  } finally {
    html.Url.revokeObjectUrl(url);
  }
}
