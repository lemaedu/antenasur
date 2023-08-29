import 'package:flutter/material.dart';

class AppTheme {
  static const Color primary = Colors.lightBlue;

  static final ThemeData lightTheme = ThemeData.light().copyWith(
    //Color primario
    primaryColor: Colors.lightBlue,

    appBarTheme: const AppBarTheme(
      color: primary,
      elevation: 0,
    ),

    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(foregroundColor: primary),
    ),

    listTileTheme: const ListTileThemeData(
      iconColor: primary,
      //textColor:Colors.white,
      //titleTextStyle:  TextStyle(fontSize: 24),
    ),

    drawerTheme: const DrawerThemeData(
      //backgroundColor:primary, todo de color primario
      scrimColor: Colors.black54,
    ),

    //FloatingActionButton
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: primary,
    ),

    elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
            backgroundColor: primary,
            shape: const BeveledRectangleBorder(),
            elevation: 1)),
    //TextFormField
    inputDecorationTheme: const InputDecorationTheme(
      floatingLabelStyle: TextStyle(color: primary),
      enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: primary),
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(10), topRight: Radius.circular(10))),
      focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: primary),
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(10), topRight: Radius.circular(10))),
      border: OutlineInputBorder(
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(10), topRight: Radius.circular(10))),
    ),
  );

  static final ThemeData dartTheme = ThemeData.dark().copyWith(
    //Color primario
    primaryColor: Colors.lightBlue,

    appBarTheme: const AppBarTheme(
      color: primary,
      elevation: 0,
    ),
    scaffoldBackgroundColor: Colors.black,
  );
}
