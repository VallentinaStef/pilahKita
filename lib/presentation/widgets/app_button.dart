import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

class AppButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final bool outlined;
  final Color color;
  final Color? textColor;

  const AppButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.outlined = false,
    this.color = AppColors.green,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    final fontColor =
        textColor ?? (outlined ? AppColors.green : Colors.white);

    const leafShape = BorderRadius.only(
      topLeft: Radius.circular(36),
      bottomRight: Radius.circular(36),
      topRight: Radius.circular(4),
      bottomLeft: Radius.circular(4),
    );

    return Container(
      height: 42,
      decoration: BoxDecoration(
        color: outlined ? Colors.white : color,
        borderRadius: leafShape,
        border: outlined ? Border.all(color: fontColor, width: 2) : null,
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: leafShape,
          onTap: onPressed,
          child: Center(
            child: Text(
              text,
              style: TextStyle(
                color: fontColor,
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
