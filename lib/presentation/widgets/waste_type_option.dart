import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../themes/app_colors.dart';

class WasteTypeOption extends StatelessWidget {
  final String label;
  final Color iconColor;
  final bool isSelected;
  final bool hasError;
  final VoidCallback onTap;

  const WasteTypeOption({
    super.key,
    required this.label,
    required this.iconColor,
    required this.isSelected,
    this.hasError = false,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 88,
        height: 88,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: isSelected ? AppColors.accent : AppColors.surface,
          border: Border.all(
            color:
                isSelected
                    ? AppColors.primary
                    : hasError
                    ? AppColors.danger
                    : iconColor.withValues(alpha: 0.42),
            width: isSelected ? 1.5 : 1,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                SvgPicture.asset(
                  'lib/assets/trash_bin.svg',
                  width: 32,
                  height: 32,
                  colorFilter: ColorFilter.mode(iconColor, BlendMode.srcIn),
                ),
                SvgPicture.asset(
                  'lib/assets/trash_top.svg',
                  width: 32,
                  height: 32,
                ),
              ],
            ),
            Text(
              label,
              style: TextStyle(
                color: AppColors.primary,
                fontSize: 12,
                fontWeight: isSelected ? FontWeight.w700 : FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
