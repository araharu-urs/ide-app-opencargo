 import 'package:flutter/material.dart';

Widget buildBadge(String role) {
    Color bgColor;
    Color textColor;
    switch (role.toLowerCase()) {
      case 'agencia':
        bgColor = Colors.red[100]!;
        textColor = Colors.red[800]!;
        break;
      case 'transporte':
        bgColor = Colors.green[100]!;
        textColor = Colors.green[800]!;
        break;
      case 'moderador':
        bgColor = Colors.orange[100]!;
        textColor = Colors.orange[800]!;
        break;
      default:
        bgColor = Colors.grey[300]!;
        textColor = Colors.black54;
    }
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        role.toUpperCase(),
        style: TextStyle(color: textColor, fontWeight: FontWeight.bold, fontSize: 14),
      ),
    );
  }