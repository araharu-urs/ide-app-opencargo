  import 'package:flutter/material.dart';
import 'package:get/get.dart';

Widget buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0, left: 8),
      child: Text(
        title,
        style: Theme.of(Get.context!).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: Theme.of(Get.context!)
                  .colorScheme
                  .onBackground
                  .withOpacity(0.6),
            ),
      ),
    );
  }