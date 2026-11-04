import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class WasteSizeOption extends StatelessWidget {
  final String label;
  final bool isSelected;
  final bool hasError;
  final VoidCallback onTap;

  const WasteSizeOption({
    super.key,
    required this.label,
    required this.isSelected,
    this.hasError = false,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          height: 44,
          decoration: BoxDecoration(
            color: isSelected ? AppColors.lime : Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color:
                  isSelected
                      ? AppColors.darkGreen
                      : hasError
                      ? AppColors.red
                      : AppColors.border.withValues(alpha: 0.7),
              width: 1,
            ),
          ),
          child: Center(
            child: Text(
              label,
              style: TextStyle(
                color: AppColors.darkGreen,
                fontSize: 12,
                fontWeight: isSelected ? FontWeight.w700 : FontWeight.w600,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
