import 'package:flutter/material.dart';

import '../../theme/app_colors.dart';

class MapPlaceholder extends StatelessWidget {
  final String address;

  const MapPlaceholder({
    super.key,
    required this.address,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 190,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: const Color(0xFFD9EBD2),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Stack(
        children: [
          Positioned(
            left: -20,
            top: 30,
            child: Transform.rotate(
              angle: -0.25,
              child: Container(
                width: 420,
                height: 20,
                color: Colors.white,
              ),
            ),
          ),
          Positioned(
            left: 30,
            top: 90,
            child: Transform.rotate(
              angle: 0.25,
              child: Container(
                width: 380,
                height: 15,
                color: const Color(0xFF9CC9D2),
              ),
            ),
          ),
          const Center(
            child: Icon(
              Icons.location_on,
              color: Color(0xFFC65C35),
              size: 45,
            ),
          ),
          Positioned(
            left: 12,
            bottom: 12,
            right: 12,
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.94),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                '$address • Peta ilustrasi, bukan GPS asli',
                style: const TextStyle(
                  fontSize: 11,
                  color: AppColors.textDark,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}