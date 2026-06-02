 import 'package:flutter/material.dart';

Color getStatusColor(String status) {
  switch (status) {
    case "Online":
      return Colors.green;
    case "Busy":
      return Colors.orange;
    default:
      return Colors.grey;
  }
}