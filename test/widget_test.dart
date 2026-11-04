// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';

import 'package:pilahkita/main.dart';

void main() {
  testWidgets('Report page loads', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    expect(find.text('Laporkan sampah'), findsOneWidget);
    expect(find.text('Foto wajib diisi'), findsOneWidget);
    expect(find.text('Kirim laporan'), findsOneWidget);
  });
}
