import 'package:flutter/material.dart';

/// Menjaga lebar halaman role Petugas tetap seperti layar ponsel saat
/// aplikasi dijalankan melalui Chrome pada layar desktop.
class PetugasPageFrame extends StatelessWidget {
  final Widget child;
  const PetugasPageFrame({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Align(
          alignment: Alignment.topCenter,
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: 480,
              minHeight: constraints.maxHeight,
            ),
            child: SizedBox(width: double.infinity, child: child),
          ),
        );
      },
    );
  }
}
