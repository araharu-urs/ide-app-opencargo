import 'package:flutter/material.dart';
import 'package:get/get.dart';

Widget buildInfoLabel(String title) {
  return Padding(
    padding: const EdgeInsets.only(top: 10, bottom: 4),
    child: Text(
      title,
      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
    ),
  );
}

