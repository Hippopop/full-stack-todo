import 'package:flutter/material.dart';

class ColorsTheme extends ThemeExtension<ColorsTheme> {
  final Color white;
  final Color black;
  final Color extraColor;
  final Color mainAccent;
  final Color primaryColor;
  final Color primaryAccent;
  final Color secoderyAccent;
  final Color extraTextColor;
  final Color backgroundColor;
  ColorsTheme({
    required this.black,
    required this.white,
    required this.extraColor,
    required this.mainAccent,
    required this.primaryColor,
    required this.primaryAccent,
    required this.secoderyAccent,
    required this.extraTextColor,
    required this.backgroundColor,
  });

  @override
  ColorsTheme copyWith({
    Color? black,
    Color? white,
    Color? mainAccent,
    Color? extraColor,
    Color? primaryColor,
    Color? primaryAccent,
    Color? secoderyAccent,
    Color? extraTextColor,
    Color? backgroundColor,
  }) {
    return ColorsTheme(
      white: white ?? this.white,
      black: black ?? this.black,
      mainAccent: mainAccent ?? this.mainAccent,
      extraColor: extraColor ?? this.extraColor,
      primaryColor: primaryColor ?? this.primaryColor,
      primaryAccent: primaryAccent ?? this.primaryAccent,
      secoderyAccent: secoderyAccent ?? this.secoderyAccent,
      extraTextColor: extraTextColor ?? this.extraTextColor,
      backgroundColor: backgroundColor ?? this.backgroundColor,
    );
  }

  @override
  ThemeExtension<ColorsTheme> lerp(
      covariant ThemeExtension<ColorsTheme>? other, double t) {
    if (other is! ColorsTheme) return this;
    return ColorsTheme(
      white: Color.lerp(white, other.white, t)!,
      black: Color.lerp(black, other.black, t)!,
      mainAccent: Color.lerp(mainAccent, other.mainAccent, t)!,
      extraColor: Color.lerp(extraColor, other.extraColor, t)!,
      primaryColor: Color.lerp(primaryColor, other.primaryColor, t)!,
      primaryAccent: Color.lerp(primaryAccent, other.primaryAccent, t)!,
      secoderyAccent: Color.lerp(secoderyAccent, other.secoderyAccent, t)!,
      extraTextColor: Color.lerp(extraTextColor, other.extraTextColor, t)!,
      backgroundColor: Color.lerp(backgroundColor, other.backgroundColor, t)!,
    );
  }
}
