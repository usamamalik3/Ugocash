import 'package:flutter/material.dart';
import 'package:ugocash/styles/colors.dart';

String gilroyFontFamily = "Gilroy";

ThemeData themeData = ThemeData(
  
  cardColor: AppColors.secondaryColor,
  bottomSheetTheme: BottomSheetThemeData(backgroundColor: AppColors.backgroundColor),
  iconTheme: IconThemeData(color: AppColors.textColor),

  scaffoldBackgroundColor: AppColors.backgroundColor,
  elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        
    backgroundColor: AppColors.primaryColor,
  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
   
  )),
  textButtonTheme: TextButtonThemeData(
    
      style: TextButton.styleFrom(backgroundColor: AppColors.secondaryColor, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),)),
    
  textTheme: const TextTheme(
    headlineLarge: TextStyle(
      color: AppColors.textColor,
      fontSize: 32,
    ),
    
    headlineMedium: TextStyle(
      color: AppColors.primaryfieldColor,
      fontSize: 32,
    ),
    headlineSmall: TextStyle(
   
      color: AppColors.textColor,
      fontSize: 30,
 
    ),
    
    titleMedium: TextStyle(
      fontSize: 16,
      color: AppColors.textColor,
    ),
    titleLarge: TextStyle(
      color: AppColors.textColor,
      fontSize: 18,
    
    
    ),
    labelLarge: TextStyle(
      color: AppColors.textColor,
      fontSize: 18,
    ),
    
    labelMedium: TextStyle(
      color: AppColors.textColor,
      fontSize: 16,
    ),
    labelSmall: TextStyle(
      color: AppColors.textColor,
      fontSize: 12,
    ),
  ),
  
  checkboxTheme: const CheckboxThemeData( side: BorderSide(color: AppColors.textColor, )),
  floatingActionButtonTheme:const  FloatingActionButtonThemeData(),
  bottomNavigationBarTheme:  const BottomNavigationBarThemeData(
      backgroundColor: AppColors.secondaryColor,
      unselectedItemColor: AppColors.backgroundColor,
      selectedItemColor: AppColors.textColor),
      
  inputDecorationTheme: InputDecorationTheme(
    suffixIconColor: AppColors.textColor,
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
