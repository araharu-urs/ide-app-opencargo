import 'package:open_cargo/views/auth/user/agencia/widgets/badge.dart';
import 'package:open_cargo/views/auth/user/agencia/widgets/crear_viaje_modal.dart';
import 'package:flutter/material.dart';

Widget buildCargaCard(String avatar, String nombre, String email, String flota, String estado) {
  return Container(
    padding: const EdgeInsets.all(16),
    margin: const EdgeInsets.only(bottom: 10), // Espaciado entre tarjetas
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(15),
      boxShadow: [
        BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 8, offset: const Offset(0, 4)),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 🔹 Encabezado con usuario y estado
        Row(
          children: [
            CircleAvatar(
              backgroundColor: Colors.purple[100],
              radius: 24,
              child: Text(
                avatar,
                style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.purple, fontSize: 18),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(nombre, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  Text(email, style: const TextStyle(fontSize: 14, color: Colors.grey)),
                ],
              ),
            ),
            buildBadge(estado), // 🔹 Badge de estado
          ],
        ),

        const SizedBox(height: 10),

        // 🔹 Flota a operar con distribución mejorada
        RichText(
          text: TextSpan(
            style: const TextStyle(fontSize: 14, color: Colors.black),
            children: [
              const TextSpan(text: "Flota a operar: ", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black54)),
              TextSpan(text: flota, style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.black87)),
            ],
          ),
        ),

        const SizedBox(height: 15),

        // 🔹 Botón "Ver detalles" mejor alineado
        Align(
          alignment: Alignment.centerRight,
          child: TextButton.icon(
            onPressed: () => showDetailsModal(1),
            icon: const Icon(Icons.info_outline, color: Colors.blueAccent),
            label: const Text("Ver detalles", style: TextStyle(color: Colors.blueAccent, fontWeight: FontWeight.bold)),
          ),
        ),
      ],
    ),
  );
}