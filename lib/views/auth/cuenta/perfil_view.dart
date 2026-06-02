import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:open_cargo/constantes.dart';

class ProfileEditView extends StatelessWidget {
  const ProfileEditView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    // Controladores para los campos (puedes usar un controller real en implementación completa)
    final nameController = TextEditingController(text: 'Transportes Mendoza S.A. de C.V.');
    final caatController = TextEditingController(text: 'MXT123456');
    final rfcController = TextEditingController(text: 'MEN890101ABC');
    final descripcionController = TextEditingController(
        text: 'Empresa con más de 20 años en el sector logístico. Especializada en transporte terrestre nacional y cumplimiento normativo.');

    return Scaffold(
      appBar: AppBar(
        title: Text('profile'.tr),
        backgroundColor: ThemeUi.principal,
        iconTheme: const IconThemeData(color: Colors.white),
        centerTitle: true,
        elevation: 0,
      ),
      backgroundColor: theme.scaffoldBackgroundColor,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Avatar
            Center(
              child: CircleAvatar(
                radius: 50,
                backgroundColor: Colors.blue[100],
                child: Text(
                  'T',
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    color: Colors.blueAccent,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),

            _buildInputField(label: 'company_name'.tr, controller: nameController),
            _buildInputField(label: 'caat'.tr, controller: caatController),
            _buildInputField(label: 'rfc'.tr, controller: rfcController),

            const SizedBox(height: 10),

            Align(
              alignment: Alignment.centerLeft,
              child: Text('certifications'.tr, style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
            ),
            const SizedBox(height: 8),
            Column(
              children: [
                _buildCertificationTile('ISO 9001:2015'),
                _buildCertificationTile('Norma NOM-087'),
                _buildCertificationTile('Transporte Limpio'),
              ],
            ),

            const SizedBox(height: 20),
            _buildMultilineInputField(label: 'company_description'.tr, controller: descripcionController),

            const SizedBox(height: 10),
            Align(
              alignment: Alignment.centerLeft,
              child: Text('company_presentation'.tr, style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
            ),
            const SizedBox(height: 8),
            TextButton.icon(
              onPressed: () => Get.snackbar('download'.tr, 'downloading_presentation'.tr),
              icon: const Icon(Icons.picture_as_pdf, color: Colors.redAccent),
              label: Text('download_pdf'.tr),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInputField({required String label, required TextEditingController controller}) {
    final theme = Theme.of(Get.context!);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          filled: true,
          fillColor: theme.inputDecorationTheme.fillColor ?? Colors.grey[200],
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
        ),
      ),
    );
  }

  Widget _buildMultilineInputField({required String label, required TextEditingController controller}) {
    final theme = Theme.of(Get.context!);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: TextField(
        controller: controller,
        maxLines: 5,
        decoration: InputDecoration(
          labelText: label,
          filled: true,
          fillColor: theme.inputDecorationTheme.fillColor ?? Colors.grey[200],
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
        ),
      ),
    );
  }

  Widget _buildCertificationTile(String text) {
    final theme = Theme.of(Get.context!);
    return Row(
      children: [
        Icon(Icons.check_circle, size: 18, color: Colors.green[600]),
        const SizedBox(width: 8),
        Text(text, style: theme.textTheme.bodyMedium),
      ],
    );
  }
}
