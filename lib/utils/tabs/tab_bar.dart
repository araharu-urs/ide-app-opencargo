import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:open_cargo/controllers/utils/tab_controller.dart';
import 'package:open_cargo/widgets/custom_header.dart';
import 'package:open_cargo/constantes.dart';

class TabBarViewX extends StatelessWidget {
  const TabBarViewX({super.key});

  @override
  Widget build(BuildContext context) {
    final TabControllerX controller = Get.find<TabControllerX>();
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: const CustomHeader(),
      body: Obx(() {
        if (controller.pages.isEmpty) {
          return const Center(child: CircularProgressIndicator());
        }
        return IndexedStack(
          index: controller.selectedIndex.value,
          children: controller.pages,
        );
      }),
      bottomNavigationBar: Obx(() {
        if (controller.pages.isEmpty) {
          return const SizedBox.shrink();
        }

        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              height: 1,
              color: isDark ? Colors.grey[800] : Colors.grey[300],
            ),
            ClipRect(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 15, sigmaY: 40),
                child: Container(
                  color: theme.scaffoldBackgroundColor.withOpacity(0.85),
                  child: BottomNavigationBar(
                    backgroundColor: theme.scaffoldBackgroundColor,
                    elevation: 0,
                    currentIndex: controller.selectedIndex.value,
                    onTap: controller.changeTab,
                    selectedItemColor: ThemeUi.principal,
                    unselectedItemColor: theme.hintColor,
                    showSelectedLabels: true,
                    showUnselectedLabels: true,
                    type: BottomNavigationBarType.fixed,
                    selectedLabelStyle: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                    unselectedLabelStyle: const TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 12,
                    ),
                    items: List.generate(controller.pages.length, (index) {
                      final translatedTitle = controller.titles[index].tr;
                      return BottomNavigationBarItem(
                        icon: Icon(_getIconForTitle(controller.titles[index])),
                        label: translatedTitle,
                      );
                    }),
                  ),
                ),
              ),
            ),
          ],
        );
      }),
    );
  }

  IconData _getIconForTitle(String title) {
    switch (title) {
      case "Home":
        return Icons.home;
      case "Profile":
        return Icons.person;
      case "Settings":
        return Icons.settings;
      case "Agencia":
        return Icons.business;
      case "Transporte":
        return Icons.local_shipping;
      case "Público":
        return Icons.people;
      default:
        return Icons.help_outline;
    }
  }
}
