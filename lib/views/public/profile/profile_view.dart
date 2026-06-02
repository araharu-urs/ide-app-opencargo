import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:open_cargo/constantes.dart';
import 'package:open_cargo/models/user/user_model.dart';
import 'package:open_cargo/views/public/profile/widgets/action_button.dart';
import 'package:open_cargo/views/public/profile/widgets/chip.dart';
import 'package:open_cargo/views/public/profile/widgets/info_card.dart';
import 'package:open_cargo/views/public/profile/widgets/titulo.dart';

class UserDetailView extends StatelessWidget {
  const UserDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    final UserModel user = Get.arguments as UserModel;
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          user.name,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        backgroundColor: ThemeUi.principal,
        iconTheme: const IconThemeData(color: Colors.white),
        actions: [
          IconButton(
            icon: const Icon(Icons.share, color: Colors.white, size: 26),
            onPressed: () {},
          ),
        ],
      ),
      backgroundColor: theme.scaffoldBackgroundColor,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 🔹 Encabezado
            Center(
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: ThemeUi.principal.withOpacity(0.3),
                        width: 3,
                      ),
                    ),
                    child: CircleAvatar(
                      radius: 60,
                      backgroundColor: Colors.purple[100],
                      child: Text(
                        user.name[0],
                        style: TextStyle(
                          fontSize: 48,
                          fontWeight: FontWeight.bold,
                          color: Colors.purple[800],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    user.name,
                    style: theme.textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    user.description,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: theme.hintColor,
                      height: 1.4,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),

            const SizedBox(height: 30),

            // 🔹 Acciones
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                buildActionButton(
                  icon: Icons.phone,
                  label: "call".tr,
                  color: Colors.green,
                  onPressed: () {},
                ),
                buildActionButton(
                  icon: Icons.message,
                  label: "message".tr,
                  color: Colors.blue,
                  onPressed: () {},
                ),
                buildActionButton(
                  icon: Icons.email,
                  label: "email".tr,
                  color: Colors.purple,
                  onPressed: () {},
                ),
              ],
            ),

            const SizedBox(height: 30),

            // 🔹 Información
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  buildSectionTitle("contact_info".tr),
                  const SizedBox(height: 15),
                  buildInfoCard(
                    icon: Icons.phone,
                    title: "phone".tr,
                    subtitle: "+52 55 1234 5678",
                  ),
                  const SizedBox(height: 15),
                  buildInfoCard(
                    icon: Icons.email,
                    title: "email".tr,
                    subtitle: "contacto@empresa.com",
                  ),
                  const SizedBox(height: 15),
                  buildInfoCard(
                    icon: Icons.location_pin,
                    title: "location".tr,
                    subtitle: "CDMX, México",
                  ),
                  const SizedBox(height: 30),
                  buildSectionTitle("services_offered".tr),
                  const SizedBox(height: 15),
                  Wrap(
                    spacing: 10,
                    runSpacing: 10,
                    children: [
                      buildServiceChip("heavy_transport".tr, Icons.local_shipping),
                      buildServiceChip("refrigerated_cargo".tr, Icons.ac_unit),
                      buildServiceChip("international_logistics".tr, Icons.language),
                      buildServiceChip("insured".tr, Icons.security),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
