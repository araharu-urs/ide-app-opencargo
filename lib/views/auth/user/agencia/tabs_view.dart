import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:open_cargo/views/auth/user/agencia/viajes/viajes_view.dart';
import 'package:open_cargo/views/auth/user/profile/tabs/mi_flota_view.dart';
import 'package:open_cargo/views/auth/user/profile/tabs/profile_view.dart';
import 'package:open_cargo/views/auth/user/profile/tabs/status_view.dart';
import 'package:open_cargo/views/auth/user/profile/widgets/badge_rol.dart';
import 'package:open_cargo/views/auth/user/profile/tabs/contactos_view.dart';
import 'package:open_cargo/views/auth/user/profile/widgets/lista_opciones.dart';

class TabAgenciaView extends StatelessWidget {
   TabAgenciaView({super.key});

  @override
  Widget build(BuildContext context) {
      final box = GetStorage();
    final String role = box.read('rol') ?? '';

    final bool esAgencia = role == 'Transporte';
       final List<Tab> tabs = [
      const Tab(text: "Viajes"),
      const Tab(text: "Negociaciones"),
     
    ];

    final List<Widget> views = [
      AgenciaView(),
      TabStatus(),
    
    ];
    return DefaultTabController(
      length: tabs.length,
      child: Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(kTextTabBarHeight),
          child: AppBar(
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            elevation: 0,
            iconTheme: IconThemeData(color: Theme.of(context).iconTheme.color),
            bottom:  TabBar(
              indicatorColor: Colors.blueAccent,
              labelColor: Colors.blueAccent,
              unselectedLabelColor: Colors.grey,
              tabs: tabs,
            ),
          ),
        ),
         body: TabBarView(children: views),
      ),
    );
  }
}
