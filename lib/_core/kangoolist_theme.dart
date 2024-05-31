import 'package:flutter/material.dart';
import 'package:flutter_kangoolist/_core/constants/kangoolist_colors.dart';

class KangooListTheme {
  static ThemeData mainTheme = ThemeData(
    // Usar Material Design 3
    useMaterial3: true,

    // Paleta de cores principal
    primarySwatch: Colors.teal,

    // Cor de fundo em telas que usam Scaffold
    scaffoldBackgroundColor: Color.fromARGB(255, 126, 255, 218),

    // Tema dos FloatingActionButton
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: Color.fromARGB(255, 221, 255, 243),
    ),

    // Temas dos ListTiles
    listTileTheme: const ListTileThemeData(
      iconColor: KangooListColors.graydark,
      contentPadding: EdgeInsets.zero,
    ),

    // Tema das AppBars
    appBarTheme: const AppBarTheme(
      toolbarHeight: 72,
      centerTitle: true,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(32),
        ),
      ),
    ),

    // Tema dos Dividers
    dividerTheme: const DividerThemeData(
      color: KangooListColors.graydark,
    ),

    // Tema dos TextFormFields
    inputDecorationTheme: const InputDecorationTheme(
      iconColor: Colors.black,
      labelStyle: TextStyle(color: Colors.black),
    ),
  );
}
