import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class TabFlota extends StatelessWidget {
  const TabFlota({super.key});
 List<Map<String, dynamic>> get _flotaDePrueba => [
    {
      'modelo': 'Kenworth T680',
      'placas': 'ABC-1234',
      'anio': 2021,
      'estado': 'Activo'
    },
    {
      'modelo': 'Freightliner Cascadia',
      'placas': 'XYZ-5678',
      'anio': 2020,
      'estado': 'En mantenimiento'
    },
    {
      'modelo': 'Volvo VNL 760',
      'placas': 'JKL-9012',
      'anio': 2022,
      'estado': 'Activo'
    },
  ];
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final storage = GetStorage();
    final role = storage.read('rol') ?? '';
    final flota = _flotaDePrueba;

    
    if (role != 'Transporte') {
      return const Scaffold(
        body: Center(child: Text("Acceso denegado")),
      );
    }

    return Scaffold(
     
      backgroundColor: theme.scaffoldBackgroundColor,
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: flota.length,
        separatorBuilder: (_, __) => const SizedBox(height: 12),
        itemBuilder: (context, index) {
          final camion = flota[index];
          return Card(
            elevation: 3,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            color: theme.cardColor,
            child: ListTile(
              contentPadding: const EdgeInsets.all(16),
              leading: CircleAvatar(
                backgroundColor: Colors.blue[100],
                child: Icon(Icons.local_shipping, color: Colors.blueAccent),
              ),
              title: Text(
                camion['modelo'],
                style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Placas: ${camion['placas']}", style: theme.textTheme.bodySmall),
                  Text("Año: ${camion['anio']}", style: theme.textTheme.bodySmall),
                  Text("Estado: ${camion['estado']}", style: theme.textTheme.bodySmall?.copyWith(
                    color: camion['estado'] == 'Activo' ? Colors.green : Colors.grey,
                  )),
                ],
              ),
              trailing: Icon(Icons.arrow_forward_ios, color: theme.iconTheme.color, size: 16),
              onTap: () {
                Get.snackbar("Camión", "Detalles de: ${camion['modelo']}");
              },
            ),
          );
        },
      ),
    );
  }

 
}
