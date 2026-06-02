  import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:open_cargo/controllers/public/home_controller.dart';

Widget buildSearchBar(HomeController homeController) {
  final isDark = Get.isDarkMode;
  final theme = Theme.of(Get.context!);

  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 12),
    decoration: BoxDecoration(
      color: isDark ? Colors.grey[800] : Colors.grey[200],
      borderRadius: BorderRadius.circular(30),
    ),
    child: Row(
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: isDark ? Colors.grey[700] : Colors.grey[300],
            borderRadius: const BorderRadius.horizontal(left: Radius.circular(30)),
          ),
          child: Icon(Icons.search,
              color: isDark ? Colors.white70 : Colors.black54, size: 20),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: TextField(
            showCursor: true,
            onChanged: (value) {
              homeController.searchQuery.value = value;
            },
            style: TextStyle(
              color: theme.textTheme.bodyMedium?.color,
              fontSize: 16,
            ),
            decoration: InputDecoration(
              hintText: "Buscar entre tus viajes",
              hintStyle: TextStyle(
                color: isDark ? Colors.white60 : Colors.black45,
                fontSize: 16,
              ),
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(vertical: 14),
            ),
          ),
        ),
      ],
    ),
  );
}
