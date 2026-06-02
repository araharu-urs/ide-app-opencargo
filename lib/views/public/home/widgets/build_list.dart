import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:open_cargo/controllers/public/home_controller.dart';
import 'package:open_cargo/views/public/profile/profile_view.dart';
import 'package:open_cargo/widgets/no_data_found.dart';

Widget buildList(HomeController homeController) {
    return Obx(() {
      if (homeController.isLoading.value) {
        return const Center(
            child: CircularProgressIndicator()); // Loader cuando está cargando
      }
      if (homeController.filteredUsers.isEmpty) {
        return EmptyDataWidget();
      }
      return ListView.separated(
        padding: const EdgeInsets.all(5),
        itemCount: homeController.filteredUsers.length,
        separatorBuilder: (context, index) =>
            Divider(color: Colors.grey[300]), // Línea separadora suave
        itemBuilder: (context, index) {
          final item = homeController.filteredUsers[index];

          return ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.purple[100],
              child: Text(
                item.initial,
                style: TextStyle(
                    fontWeight: FontWeight.bold, color: Colors.purple[800]),
              ),
            ),
            title: Text(item.name,
                style: const TextStyle(fontWeight: FontWeight.bold)),
            subtitle: Text(item.rol, style: TextStyle(color: Colors.grey[600])),
            trailing: const Icon(Icons.chevron_right, color: Colors.grey),
            onTap: () {
              Get.to(() => const UserDetailView(), arguments: item);
            },
          );
        },
      );
    });
  }