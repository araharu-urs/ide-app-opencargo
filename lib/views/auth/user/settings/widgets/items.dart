  import 'package:flutter/material.dart';
import 'package:get/get.dart';

Widget buildSettingsItem(IconData icon, String title, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        margin: const EdgeInsets.symmetric(vertical: 5),
        decoration: BoxDecoration(
          color: Theme.of(Get.context!).cardColor,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.03),
                blurRadius: 5,
                offset: const Offset(0, 3)),
          ],
        ),
        child: Row(
          children: [
            Icon(icon, color: Theme.of(Get.context!).colorScheme.primary),
            const SizedBox(width: 15),
            Expanded(
              child: Text(
                title,
                style: Theme.of(Get.context!).textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
              ),
            ),
            Icon(Icons.arrow_forward_ios,
                size: 16,
                color: Theme.of(Get.context!)
                    .colorScheme
                    .onSurface
                    .withOpacity(0.6)),
          ],
        ),
      ),
    );
  }