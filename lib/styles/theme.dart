import 'package:flutter/material.dart';
import 'package:ugocash/styles/colors.dart';

String gilroyFontFamily = "Gilroy";

ThemeData themeData = ThemeData(
  cardColor: AppColors.secondaryColor,
  bottomSheetTheme: BottomSheetThemeData(backgroundColor: AppColors.backgroundColor),
  iconTheme: IconThemeData(color: AppColors.textColor2),

  scaffoldBackgroundColor: AppColors.backgroundColor,
  elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
    backgroundColor: AppColors.primaryColor,
  )),
  textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(backgroundColor: AppColors.secondaryColor)),
  textTheme: const TextTheme(
    headlineLarge: TextStyle(
      color: AppColors.textColor2,
      fontSize: 32,
    ),
    
    headlineMedium: TextStyle(
      color: AppColors.primaryfieldColor,
      fontSize: 32,
    ),
    headlineSmall: TextStyle(
      letterSpacing: 0.5,
      color: AppColors.textColor2,
      fontSize: 30,
 
    ),
    
    titleMedium: TextStyle(
      letterSpacing: 1.0,
      fontSize: 14,
      color: AppColors.textColor2,
    ),
    titleLarge: TextStyle(
      color: AppColors.textColor2,
      fontSize: 24,
    
    
    ),
    labelLarge: TextStyle(
      color: AppColors.textColor2,
      fontSize: 18,
    ),
    labelMedium: TextStyle(
      color: AppColors.textColor2,
      fontSize: 16,
    ),
    labelSmall: TextStyle(
      color: AppColors.textColor2,
      fontSize: 12,
    ),
  ),
  floatingActionButtonTheme:const  FloatingActionButtonThemeData(),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: AppColors.secondaryColor,
      unselectedItemColor: AppColors.backgroundColor,
      selectedItemColor: AppColors.textColor2),
  inputDecorationTheme: InputDecorationTheme(
    suffixIconColor: AppColors.textColor2,
    labelStyle: const TextStyle(
      color: AppColors.textColor2
    ),
    hintStyle:const TextStyle(
      color: AppColors.textColor2
    ),
    focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: const BorderSide(width: 0.7, color: AppColors.errorColor)),
    focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide:
            const BorderSide(width: 2.0, color: AppColors.secondaryColor)),
    enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide:
            const BorderSide(width: 2.0, color: AppColors.secondaryColor)),
    border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide:
            const BorderSide(width: 2.0, color: AppColors.secondaryColor)),
    disabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide:
            const BorderSide(width: 2.0, color: AppColors.disabledColor)),
  ),
  fontFamily: gilroyFontFamily,
  visualDensity: VisualDensity.adaptivePlatformDensity,
  colorScheme:
      ColorScheme.fromSwatch().copyWith(secondary: AppColors.primaryColor),
  appBarTheme: const AppBarTheme(
    titleTextStyle:TextStyle(fontSize: 18) ,
      backgroundColor: AppColors.secondaryColor, centerTitle: true),
);
