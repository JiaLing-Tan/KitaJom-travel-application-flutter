import 'package:flutter/material.dart';
import 'dart:math';

const black = Colors.black;
const titleGreen = Color(0xff255152);
const buttonGreen = Color(0xff286A5B);
const mainGreen = Color(0xff549A6D);
const lightGreen = Color(0xff9ABE86);
const darkGray = Color(0xff7A7D79);
const lightGrey = Color(0xffD9D9D9);
const white = Colors.white;
const yellow = Color(0xffF3A95E);
const orange = Color(0xffF77037);
const selectedGreen = Color(0xffDDEDDF);
const buttonText = Color(0xffFCFFE3);



MaterialColor generateMaterialColor(Color color) {
  return MaterialColor(color.value, {
    50: tintColor(color, 0.9),
    100: tintColor(color, 0.8),
    200: tintColor(color, 0.6),
    300: tintColor(color, 0.4),
    400: tintColor(color, 0.2),
    500: color,
    600: shadeColor(color, 0.1),
    700: shadeColor(color, 0.2),
    800: shadeColor(color, 0.3),
    900: shadeColor(color, 0.4),
  });
}

int tintValue(int value, double factor) =>
    max(0, min((value + ((255 - value) * factor)).round(), 255));

Color tintColor(Color color, double factor) => Color.fromRGBO(
    tintValue(color.red, factor),
    tintValue(color.green, factor),
    tintValue(color.blue, factor),
    1);

int shadeValue(int value, double factor) =>
    max(0, min(value - (value * factor).round(), 255));

Color shadeColor(Color color, double factor) => Color.fromRGBO(
    shadeValue(color.red, factor),
    shadeValue(color.green, factor),
    shadeValue(color.blue, factor),
    1);
