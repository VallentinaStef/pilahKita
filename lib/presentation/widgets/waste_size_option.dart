import 'package:flutter/material.dart';
import '../themes/app_colors.dart';

class WasteSizeOption extends StatelessWidget {
  final String label;
  final bool isSelected;
  final bool hasError;
  final Color backgroundColor;
  final VoidCallback onTap;

  const WasteSizeOption({
    super.key,
    required this.label,
    required this.isSelected,
    this.hasError = false,
    this.backgroundColor = const Color(0xFFF4F7F1),
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: FilledButton(
        onPressed: onTap,
        style: FilledButton.styleFrom(
          minimumSize: const Size.fromHeight(44),
          padding: EdgeInsets.zero,
          backgroundColor: isSelected ? AppColors.primary : backgroundColor,
          foregroundColor:  Colors.white ,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          side: hasError && !isSelected
              ? const BorderSide(color: AppColors.danger, width: 1.5)
              : BorderSide.none,
          textStyle: TextStyle(
            fontSize: 12,
            fontWeight: isSelected ? FontWeight.w700 : FontWeight.w600,
          ),
        ),
        child: Text(label),
      ),
    );
  }
}
