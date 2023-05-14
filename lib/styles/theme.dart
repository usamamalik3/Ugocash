import 'package:flutter/material.dart';
import 'package:ugocash/styles/colors.dart';

String gilroyFontFamily = "Gilroy";

ThemeData themeData = ThemeData(
  iconTheme: IconThemeData(color: AppColors.textColor2),

  scaffoldBackgroundColor: AppColors.backgroundColor,
  elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
    backgroundColor: AppColors.primaryColor,
  )),
  textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(backgroundColor: AppColors.secondaryColor)),
  textTheme: const TextTheme(
    
    headlineMedium: TextStyle(
      color: AppColors.textColor2,
      fontSize: 34,
    ),
    headlineSmall: TextStyle(
      color: AppColors.primaryfieldColor,
      fontSize: 32,
      fontWeight: FontWeight.bold,
    ),
    
    titleMedium: TextStyle(
      fontSize: 16,
      color: AppColors.textColor2,
    ),
    titleSmall: TextStyle(
      color: AppColors.textColor2,
      fontSize: 20,
      fontWeight: FontWeight.bold,
    ),
    labelLarge: TextStyle(
      color: AppColors.textColor2,
      fontSize: 17,
    ),
    labelMedium: TextStyle(
      color: AppColors.textColor2,
      fontSize: 18,
    ),
    labelSmall: TextStyle(
      color: AppColors.textColor2,
      fontSize: 12,
    ),
  ),
  floatingActionButtonTheme: FloatingActionButtonThemeData(),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: AppColors.secondaryColor,
      unselectedItemColor: AppColors.backgroundColor),
  inputDecorationTheme: InputDecorationTheme(
    hintStyle: TextStyle(
      color: AppColors.textColor2
    ),
    focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(32),
        borderSide: const BorderSide(width: 0.7, color: AppColors.errorColor)),
    focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(32),
        borderSide:
            const BorderSide(width: 2.0, color: AppColors.secondaryColor)),
    enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(32),
        borderSide:
            const BorderSide(width: 2.0, color: AppColors.secondaryColor)),
    border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(32),
        borderSide:
            const BorderSide(width: 2.0, color: AppColors.secondaryColor)),
    disabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(32),
        borderSide:
            const BorderSide(width: 2.0, color: AppColors.disabledColor)),
  ),
  fontFamily: gilroyFontFamily,
  visualDensity: VisualDensity.adaptivePlatformDensity,
  colorScheme:
      ColorScheme.fromSwatch().copyWith(secondary: AppColors.primaryColor),
  appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.secondaryColor, centerTitle: true),
);
