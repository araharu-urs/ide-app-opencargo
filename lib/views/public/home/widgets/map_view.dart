 import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:get/get.dart';
import 'package:open_cargo/controllers/public/home_controller.dart';

Widget buildMapView(HomeController homeController) {
    return Expanded(
      child: Stack(
        children: [
          // Mapa de OpenStreetMap
          Obx(
            () => FlutterMap(
              mapController: homeController.mapController,
              options: MapOptions(
                initialCenter: homeController.currentPosition.value,
                initialZoom: 15.0,
              ),
              children: [
                TileLayer(
                  urlTemplate:
                      'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                  subdomains: const ['a', 'b', 'c'],
                  userAgentPackageName: 'com.example.app',
                ),
                // Marcador de la ubicación actual
                MarkerLayer(
                  markers: [
                    Marker(
                      width: 80.0,
                      height: 80.0,
                      point: homeController.currentPosition.value,
                      child: const Icon(
                        Icons.location_pin,
                        color: Colors.red,
                        size: 40,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }