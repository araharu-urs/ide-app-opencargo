 import 'package:flutter/material.dart';
import 'package:open_cargo/constantes.dart';

Widget buildServiceChip(String text, IconData icon) {
    return Chip(
      backgroundColor: Colors.blue[50],
      avatar: Icon(icon, size: 18, color: ThemeUi.principal),
      label: Text(
        text,
        style: TextStyle(color: Colors.grey[800]),
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: BorderSide(color: Colors.blue[100]!),
      ),
    );
  }