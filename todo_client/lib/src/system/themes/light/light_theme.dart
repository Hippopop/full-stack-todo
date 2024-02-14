import 'package:flutter/material.dart';

import '../extensions/colors_theme.dart';

const _theme = Colors.white;
const _opposite = Colors.black;
const _extraColor = Color(0xffF8B6C0);
const _mainAccent = Color(0xffF2B872);
const _primaryColor = Color(0xff3084F2);
const _primaryAccent = Color(0xff96D9A0);
const _extraTextColor = Color(0xff3B3C40);
const _secondaryAccent = Color(0xffA0ACF2);
const _backgroundColor = Color(0xffF2F2F2);

final lightTheme = ThemeData(
  useMaterial3: false,
  brightness: Brightness.light,
  inputDecorationTheme: const InputDecorationTheme(
    border: OutlineInputBorder(),
  ),
  extensions: {
    ColorTheme(
      theme: _theme,
      opposite: _opposite,
      extra: _extraColor,
      mainAccent: _mainAccent,
      primary: _primaryColor,
      primaryAccent: _primaryAccent,
      primaryText: _extraTextColor,
      secondaryAccent: _secondaryAccent,
      mainBackground: _backgroundColor,
    ),
  },
);
