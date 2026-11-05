import 'package:flutter/material.dart';

import '../../themes/app_colors.dart';

class PetugasBottomNav extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const PetugasBottomNav({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final items = [
      (Icons.fact_check_outlined, 'Tugas'),
      (Icons.notifications_none_rounded, 'Notifikasi'),
      (Icons.person_outline_rounded, 'Profil'),
    ];

    return SafeArea(
      top: false,
      child: Container(
        height: 70,
        margin: const EdgeInsets.fromLTRB(18, 4, 18, 10),
        padding: const EdgeInsets.all(5),
        decoration: BoxDecoration(
          color: AppColors.primary,
          borderRadius: BorderRadius.circular(28),
        ),
        child: Row(
          children: List.generate(items.length, (index) {
            final selected = currentIndex == index;
            return Expanded(
              child: InkWell(
                borderRadius: BorderRadius.circular(20),
                onTap: () => onTap(index),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 180),
                  margin: const EdgeInsets.symmetric(horizontal: 2),
                  decoration: BoxDecoration(
                    color: selected ? AppColors.accent : Colors.transparent,
                    borderRadius: BorderRadius.circular(18),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        items[index].$1,
                        size: 23,
                        color: selected ? AppColors.primary : Colors.white70,
                      ),
                      const SizedBox(height: 3),
                      Text(
                        items[index].$2,
                        style: TextStyle(
                          fontSize: 11,
                          height: 1,
                          fontWeight:
                              selected ? FontWeight.w800 : FontWeight.w500,
                          color: selected ? AppColors.primary : Colors.white70,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}