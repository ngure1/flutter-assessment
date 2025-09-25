import 'package:flutter/material.dart';

class BadgeChip extends StatelessWidget {
  const BadgeChip({super.key, required this.label});

  final String label;

  Map<String, Color> _getColorScheme() {
    final length = label.length;

    if (length <= 5) {
      return {
        'background': const Color(0xFFEFF6FF),
        'text': const Color(0xFF1D4ED8),
      };
    } else if (length <= 8) {
      return {
        'background': const Color(0xFFF0FDF4),
        'text': const Color(0xFF15803D),
      };
    } else if (length <= 12) {
      return {
        'background': const Color(0xFFFFF7ED),
        'text': const Color(0xFFEA580C), 
      };
    } else {
      return {
        'background': const Color(0xFFFEF2F2),
        'text': const Color(0xFFDC2626), 
      };
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = _getColorScheme();

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: colors['background'],
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: colors['text']!.withValues(alpha: 0.2), width: 1),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: colors['text'],
          fontSize: 12,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
