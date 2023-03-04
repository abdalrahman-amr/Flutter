import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';

import '../components/constants.dart';



ThemeData darkTheme = ThemeData(
  primarySwatch: defaultColor,
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    backgroundColor: defaultColor,
    foregroundColor: Colors.white,

  ),
  iconTheme: IconThemeData(
    color: Colors.white
  ),
  scaffoldBackgroundColor: HexColor('333739'),
  appBarTheme: AppBarTheme(
    titleSpacing: 20,
    iconTheme: IconThemeData(
      color: Colors.white,
    ),
    elevation: 0,
    backgroundColor: Colors.grey[700],
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: HexColor('333739'),
      statusBarIconBrightness: Brightness.light,
    ),
    titleTextStyle: TextStyle(
      color: Colors.white,
      fontSize: 20,
      fontWeight: FontWeight.bold,
    ),

  ),
  textTheme: TextTheme(
      bodyText1: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: Colors.white

      )
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    elevation: 20,
    backgroundColor: HexColor('333739'),
    type: BottomNavigationBarType.fixed,
    selectedItemColor: defaultColor,
    unselectedItemColor: Colors.grey,



  ),
);

ThemeData lightTheme = ThemeData(
  primarySwatch: defaultColor,
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    backgroundColor: defaultColor,
    foregroundColor: Colors.white,

  ),
  iconTheme: IconThemeData(
      color: Colors.black
  ),
  scaffoldBackgroundColor: Colors.white,
  appBarTheme: AppBarTheme(
    titleSpacing: 20,
    iconTheme: IconThemeData(
      color: Colors.black,
    ),
    elevation: 0,
    backgroundColor: Colors.grey[300],
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: Colors.white,
      statusBarIconBrightness: Brightness.dark,
    ),
    titleTextStyle: TextStyle(
      color: Colors.black,
      fontSize: 20,
      fontWeight: FontWeight.bold,
    ),

  ),
  textTheme: TextTheme(
      bodyText1: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: Colors.black

      )
  ),

  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    elevation: 20,
    type: BottomNavigationBarType.fixed,
    selectedItemColor: defaultColor,
  ),
);