import 'package:flutter/material.dart';

import '../widgets/bottom_nav_scaffold.dart';
import '../pages/beranda_page.dart';
import '../pages/notifikasi_page.dart';

class HomeShell extends StatefulWidget {
  const HomeShell({super.key});

  @override
  State<HomeShell> createState() => _HomeShellState();
}

class _HomeShellState extends State<HomeShell> {
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    return BottomNavScaffold(
      currentIndex: _index,
      onTap: (i) => setState(() => _index = i),
      child: IndexedStack(
        index: _index,
        children: const [
          BerandaPage(),
          Center(child: Text('Riwayat')),
          NotifikasiPage(),
        ],
      ),
    );
  }
}
