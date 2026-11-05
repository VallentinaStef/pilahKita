import 'package:flutter/material.dart';

// Label status berbentuk stempel yang sedikit miring
class StatusStamp extends StatelessWidget {
  final String label;
  final Color color;

  const StatusStamp({
    super.key,
    required this.label,
    this.color = Colors.deepOrange,
  });

  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: -0.06,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
        decoration: BoxDecoration(
          border: Border.all(color: color, width: 1.5),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: color,
            fontSize: 10,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
