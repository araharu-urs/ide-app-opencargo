import 'package:flutter/material.dart';
import 'package:get/get.dart';

Widget buildInfoText(String content) {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.all(10),
    margin: const EdgeInsets.only(bottom: 8),
    decoration: BoxDecoration(
      color: Get.isDarkMode ? Colors.grey[900] : Colors.grey[100],
      borderRadius: BorderRadius.circular(10),
    ),
    child: Text(
      content,
      style: TextStyle(
        fontSize: 14,
        color: Get.isDarkMode ? Colors.white70 : Colors.black87,
      ),
    ),
  );
}
