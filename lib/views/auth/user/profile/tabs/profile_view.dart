import 'package:open_cargo/views/auth/user/profile/widgets/badge_rol.dart';
import 'package:open_cargo/views/auth/user/profile/tabs/contactos_view.dart';
import 'package:open_cargo/views/auth/user/profile/widgets/info_text.dart';
import 'package:open_cargo/views/auth/user/profile/widgets/label.dart';
import 'package:open_cargo/views/auth/user/profile/widgets/lista_opciones.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class TabInformacion extends StatelessWidget {
  const TabInformacion({super.key});

  @override
  Widget build(BuildContext context) {
    final storage = GetStorage();
    final user = storage.read('user') ?? {};
    final roleStorage = storage.read('rol');
  final String? nombre = storage.read('user')?['name'];
  final String? correo = storage.read('user')?['email'];
  final String? imagen = storage.read('imagen');
    final String role = roleStorage;
    final textTheme = Theme.of(context).textTheme;

   return SingleChildScrollView(
  padding: const EdgeInsets.all(10.0),
  child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      // Avatar
      Center(
        child: CircleAvatar(
              radius: 50,
              backgroundColor:
                  Theme.of(Get.context!).primaryColor.withOpacity(0.2),
              backgroundImage: imagen != null ? NetworkImage(imagen) : null,
              child: imagen == null
                  ? Icon(Icons.person,
                      color: Theme.of(Get.context!).primaryColor, size: 35)
                  : null,
            ),
      ),
      const SizedBox(height: 15),
      Center(
        child: Text(
          nombre ?? 'sin nombre',
          style: textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
        ),
      ),
      const SizedBox(height: 5),
      Center(
        child: Text(
          correo ?? 'sin correo',
          style: textTheme.bodyMedium?.copyWith(
            color: Theme.of(context).hintColor,
          ),
        ),
      ),
      const SizedBox(height: 10),
      Center(child: buildBadge(role)),
      const SizedBox(height: 20),

      buildInfoLabel("Razón Social"),
      buildInfoText("Transportes Mendoza S.A. de C.V."),

      buildInfoLabel("CAAT"),
      buildInfoText("MXT123456"),

      buildInfoLabel("RFC"),
      buildInfoText("MEN890101ABC"),

      buildInfoLabel("Certificaciones"),
      ...[
        "ISO 9001:2015",
        "Norma NOM-087",
        "Transporte Limpio"
      ].map((cert) => Padding(
            padding: const EdgeInsets.only(left: 12.0, bottom: 4),
            child: Row(
              children: [
                Icon(Icons.check_circle, size: 18, color: Colors.green[600]),
                const SizedBox(width: 6),
                Text(cert, style: textTheme.bodyMedium),
              ],
            ),
          )),

      const SizedBox(height: 10),
      buildInfoLabel("Descripción de la Empresa"),
      buildInfoText(
        "Empresa con más de 20 años en el sector logístico. "
        "Especializada en transporte terrestre nacional y cumplimiento normativo.",
      ),

      buildInfoLabel("Presentación de la Empresa"),
      TextButton.icon(
        onPressed: () {
          // TODO: Acción para descargar PDF
          Get.snackbar("Descarga", "Iniciando descarga de presentación...");
        },
        icon: const Icon(Icons.picture_as_pdf, color: Colors.redAccent),
        label: const Text("Descargar PDF"),
      ),
    ],
  ),
);

  }
}

