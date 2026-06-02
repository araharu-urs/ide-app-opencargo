import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

Widget buildUserHeader() {
  final box = GetStorage();
  final String? nombre = box.read('user')?['name'];
  final String? correo = box.read('user')?['email'];
  final String? imagen = box.read('imagen');

  return Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Theme.of(Get.context!).cardColor,
      borderRadius: BorderRadius.circular(15),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.05),
          blurRadius: 5,
          offset: const Offset(0, 2),
        ),
      ],
    ),
    child: Row(
      children: [
        Stack(
          children: [
            CircleAvatar(
              radius: 30,
              backgroundColor:
                  Theme.of(Get.context!).primaryColor.withOpacity(0.2),
              backgroundImage: imagen != null ? NetworkImage(imagen) : null,
              child: imagen == null
                  ? Icon(Icons.person,
                      color: Theme.of(Get.context!).primaryColor, size: 35)
                  : null,
            ),
            Positioned(
              right: 0,
              bottom: 0,
              child: Container(
                width: 14,
                height: 14,
                decoration: BoxDecoration(
                  color: Colors.green,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Theme.of(Get.context!).scaffoldBackgroundColor,
                    width: 2,
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(width: 15),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              nombre ?? 'Sin nombre',
              style: Theme.of(Get.context!)
                  .textTheme
                  .titleMedium
                  ?.copyWith(fontWeight: FontWeight.bold),
            ),
            Text(
              correo ?? 'Sin correo',
              style: Theme.of(Get.context!)
                  .textTheme
                  .bodySmall
                  ?.copyWith(color: Theme.of(Get.context!).hintColor),
            ),
          ],
        ),
      ],
    ),
  );
}
