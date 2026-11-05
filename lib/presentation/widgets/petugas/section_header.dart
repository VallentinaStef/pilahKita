import 'package:flutter/material.dart';
import '../../themes/app_colors.dart';

class SectionHeader extends StatelessWidget {
  final String title;
  final String? subtitle;
  final Widget? action;
  const SectionHeader({
    super.key,
    required this.title,
    this.subtitle,
    this.action,
  });
  @override
  Widget build(BuildContext context) => Row(
    children: [
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                color: AppColors.primary,
                fontWeight: FontWeight.w900,
                fontSize: 17,
              ),
            ),
            if (subtitle != null)
              Text(
                subtitle!,
                style: const TextStyle(
                  color: AppColors.textSecondary,
                  fontSize: 11,
                ),
              ),
          ],
        ),
      ),
      if (action != null) action!,
    ],
  );
}