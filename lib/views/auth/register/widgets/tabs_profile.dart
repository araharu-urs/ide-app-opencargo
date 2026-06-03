import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:open_cargo/constantes.dart';
import 'package:open_cargo/controllers/auth/register/register_controller.dart';

Widget buildProfileSelector(RegisterController controller, ThemeData theme) {
  return Obx(() {
    if (controller.profiles.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'select_profile'.tr,
          style: const TextStyle(
            fontFamily: 'Poppins',
            fontSize: 13,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 10),
        SizedBox(
          height: 44,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: controller.profiles.length,
            separatorBuilder: (_, __) => const SizedBox(width: 8),
            itemBuilder: (context, index) {
              final profile = controller.profiles[index];
              final bool isSelected =
                  controller.selectedProfile.value == profile['label'];

              return GestureDetector(
                onTap: () {
                  controller.selectedProfile.value = profile['label'];
                  controller.selectedProfileId.value = profile['id'];
                },
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                  decoration: BoxDecoration(
                    color: isSelected ? ThemeUi.principal : theme.cardColor,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: isSelected
                          ? ThemeUi.principal
                          : theme.dividerColor,
                      width: 1.5,
                    ),
                    boxShadow: isSelected
                        ? [
                            BoxShadow(
                              color: ThemeUi.principal.withValues(alpha: 0.3),
                              blurRadius: 6,
                              offset: const Offset(0, 3),
                            )
                          ]
                        : null,
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        profile['icon'] as IconData,
                        color: isSelected
                            ? Colors.white
                            : ThemeUi.principal,
                        size: 16,
                      ),
                      const SizedBox(width: 6),
                      Text(
                        profile['label'] as String,
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 13,
                          color: isSelected
                              ? Colors.white
                              : theme.textTheme.bodyLarge?.color,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  });
}
