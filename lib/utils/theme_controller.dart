import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ThemeController extends GetxController {
  final _box = GetStorage(); 
  final _key = 'isDarkMode';

  // Reactivo para el modo del tema
  var themeMode = ThemeMode.system.obs;

  // Temas personalizados
  final lightTheme = ThemeData.light().copyWith(
    primaryColor: Colors.blue,
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: const AppBarTheme(
      color: Colors.blue,
      iconTheme: IconThemeData(color: Colors.white),
      titleTextStyle: TextStyle(
          fontFamily: 'Poppins',
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.bold),
    ),
    iconTheme: const IconThemeData(color: Colors.black),
    textTheme: const TextTheme(
      bodyLarge: TextStyle(
        color: Colors.black,
        fontFamily: 'Poppins',
      ),
      bodyMedium: TextStyle(
        color: Colors.black,
        fontFamily: 'Poppins',
      ),
      titleMedium: TextStyle(
        color: Colors.black,
        fontFamily: 'Poppins',
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Colors.white,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide.none,
      ),
      hintStyle: TextStyle(
        color: Colors.grey[600],
        fontFamily: 'Poppins',
      ),
    ),
    cardColor: Colors.white,
    dividerColor: Colors.grey[300],
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: Colors.blue,
      foregroundColor: Colors.white,
    ),
    snackBarTheme: const SnackBarThemeData(
      backgroundColor: Colors.black,
      contentTextStyle: TextStyle(fontFamily: 'Poppins', color: Colors.white),
    ),
    tabBarTheme: const TabBarTheme(
      labelColor: Colors.blue,
      unselectedLabelColor: Colors.grey,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    ),
  );

  final darkTheme = ThemeData.dark().copyWith(
    primaryColor: Colors.black,
    scaffoldBackgroundColor: const Color(0xFF121212),
    appBarTheme: AppBarTheme(
      color: Colors.grey[900],
      iconTheme: const IconThemeData(color: Colors.white),
      titleTextStyle: const TextStyle(
          fontFamily: 'Poppins',
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.bold),
    ),
    iconTheme: const IconThemeData(color: Colors.white70),
    textTheme: const TextTheme(
      bodyLarge: TextStyle(fontFamily: 'Poppins', color: Colors.white),
      bodyMedium: TextStyle(fontFamily: 'Poppins', color: Colors.white),
      titleMedium: TextStyle(fontFamily: 'Poppins', color: Colors.white),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Colors.grey[850],
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide.none,
      ),
      hintStyle: TextStyle(fontFamily: 'Poppins', color: Colors.grey[400]),
    ),
    cardColor: const Color(0xFF1E1E1E),
    dividerColor: Colors.grey[700],
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: Colors.blueGrey,
      foregroundColor: Colors.white,
    ),
    snackBarTheme: const SnackBarThemeData(
      backgroundColor: Colors.white,
      contentTextStyle: TextStyle(fontFamily: 'Poppins', color: Colors.black),
    ),
    tabBarTheme: const TabBarTheme(
      labelColor: Colors.lightBlueAccent,
      unselectedLabelColor: Colors.grey,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.blueGrey,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    ),
  );

  @override
  void onInit() {
    super.onInit();
    themeMode.value = _loadThemeFromBox() ? ThemeMode.dark : ThemeMode.light;
  }

  // Cambiar entre tema claro y oscuro
  void toggleTheme() {
    if (themeMode.value == ThemeMode.dark) {
      themeMode.value = ThemeMode.light;
      _saveThemeToBox(false);
    } else {
      themeMode.value = ThemeMode.dark;
      _saveThemeToBox(true);
    }
  }

  // Guardar preferencia del tema en almacenamiento local
  void _saveThemeToBox(bool isDarkMode) => _box.write(_key, isDarkMode);

  // Cargar preferencia del tema desde almacenamiento local
  bool _loadThemeFromBox() => _box.read<bool>(_key) ?? false;
}
