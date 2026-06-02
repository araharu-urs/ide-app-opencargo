  import 'package:flutter/material.dart';

Widget buildStatusBadge(String status) {
    Color bgColor;
    Color textColor;

    switch (status) {
      case "Online":
        bgColor = Colors.green[100]!;
        textColor = Colors.green[800]!;
        break;
      case "Busy":
        bgColor = Colors.orange[100]!;
        textColor = Colors.orange[800]!;
        break;
      case "Offline":
        bgColor = Colors.grey[300]!;
        textColor = Colors.grey[800]!;
        break;
      default:
        bgColor = Colors.grey[200]!;
        textColor = Colors.black54;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        status,
        style: TextStyle(
            color: textColor, fontSize: 12, fontWeight: FontWeight.bold),
      ),
    );
  }