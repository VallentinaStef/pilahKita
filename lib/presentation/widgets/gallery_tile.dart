import 'package:flutter/material.dart';
import '../themes/app_colors.dart';

class GalleryTile extends StatelessWidget {
  final Color color;
  final String? imagePath;
  final bool isSelected;
  final VoidCallback onTap;

  const GalleryTile({
    super.key,
    required this.color,
    this.imagePath,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(4),
          border: isSelected
              ? Border.all(color: AppColors.primary, width: 3)
              : null,
        ),
        child: imagePath == null
            ? null
            : ClipRRect(
                borderRadius: BorderRadius.circular(2),
                child: Image.asset(imagePath!, fit: BoxFit.cover),
              ),
      ),
    );
  }
}
