import 'package:flutter/material.dart';

Widget buildBadge(String estado) {
  Color bgColor;
  Color textColor;

  switch (estado) {
    case 'POR VENCER':
      bgColor = Colors.orange[100]!;
      textColor = Colors.orange[800]!;
      break;
    case 'PREMIUM':
      bgColor = Colors.blue[100]!;
      textColor = Colors.blue[800]!;
      break;
    default:
      bgColor = Colors.grey[300]!;
      textColor = Colors.black54;
  }

  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
    decoration: BoxDecoration(
      color: bgColor,
      borderRadius: BorderRadius.circular(12),
    ),
    child: Text(
      estado,
      style: TextStyle(color: textColor, fontSize: 12, fontWeight: FontWeight.bold),
    ),
  );
}
