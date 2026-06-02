import 'package:flutter/material.dart';
import 'package:open_cargo/controllers/public/home_controller.dart';
import 'package:open_cargo/views/public/home/widgets/build_list.dart';
import 'package:open_cargo/views/public/home/widgets/build_search_bar.dart';
import 'package:open_cargo/views/public/home/widgets/build_tabs.dart';

Widget buildSearchView(HomeController homeController) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildSearchBar(homeController),
          const SizedBox(height: 10),
          buildTabs(homeController), // Filtros con scroll horizontal
          const SizedBox(height: 10),
          Expanded(child: buildList(homeController)), // Lista de contactos
        ],
      ),
    );
  }