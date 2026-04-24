import 'package:flutter/material.dart';

class ProgressBar extends StatelessWidget {
  final int current;
  final int total;
  final double percentage;

  const ProgressBar({
    super.key,
    required this.current,
    required this.total,
    required this.percentage,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Progress text
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Progress',
              style: TextStyle(
                color: Color(0xFFFFED4E),
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              '$current/$total',
              style: TextStyle(
                color: Color(0xFFFFED4E),
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        SizedBox(height: 8),

        // Progress bar
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: LinearProgressIndicator(
            value: percentage,
            minHeight: 12,
            backgroundColor: Color(0xFF1A2E4A),
            valueColor: AlwaysStoppedAnimation<Color>(
              Color(0xFFFFED4E),
            ),
          ),
        ),

        SizedBox(height: 8),

        // Percentage text
        Text(
          '${(percentage * 100).toStringAsFixed(0)}%',
          style: TextStyle(
            color: Color(0xFF00D4FF),
            fontSize: 12,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
