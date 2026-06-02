  import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:open_cargo/controllers/public/home_controller.dart';
import 'package:open_cargo/views/public/home/widgets/tab_bar.dart';

Widget buildTabs(HomeController homeController) {
     final RxInt selectedIndex = 0.obs;
    return SizedBox(
      height: 40,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Obx(() => Row(
              children: List.generate(homeController.tabs.length, (index) {
                final bool isSelected = selectedIndex.value == index;
                return Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: tabItem(
                    homeController.tabs[index]["icon"],
                    homeController.tabs[index]["label"],
                    isSelected: isSelected,
                    onTap: () {
                      selectedIndex.value =
                          index; // Actualizar el tab seleccionado
                    },
                  ),
                );
              }),
            )),
      ),
    );
  }