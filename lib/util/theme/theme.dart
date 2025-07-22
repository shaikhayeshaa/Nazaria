import 'package:flutter/material.dart';
import 'package:nazaria/resources/colors.dart';

ThemeData lightmode = ThemeData(
    brightness: Brightness.light,
    colorScheme: ColorScheme.light(
      surface: MyColors.white,
      secondary: MyColors.black,
    ));

ThemeData darkmode = ThemeData(
    brightness: Brightness.dark,
    colorScheme:
        ColorScheme.dark(surface: MyColors.black, secondary: MyColors.white));
