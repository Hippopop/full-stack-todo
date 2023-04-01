import 'package:flutter/material.dart';

class NavTheme extends ThemeExtension<NavTheme> {
  final Color backgroundColor;
  final Color activeIconColor;
  final Color inactiveIconColor;
  final Color activeTextColor;
  final Color inactiveTextColor;
  const NavTheme({
    required this.backgroundColor,
    required this.activeIconColor,
    required this.inactiveIconColor,
    required this.activeTextColor,
    required this.inactiveTextColor,
  });

  @override
  NavTheme copyWith({    Color? backgroundColor,
    Color? activeIconColor,
    Color? inactiveIconColor,
    Color? activeTextColor,
    Color? inactiveTextColor,
  }) {
    return NavTheme(
      backgroundColor: backgroundColor ?? this.backgroundColor,
      activeIconColor: activeIconColor ?? this.activeIconColor,
      inactiveIconColor: inactiveIconColor ?? this.inactiveIconColor,
      activeTextColor: activeTextColor ?? this.activeTextColor,
      inactiveTextColor: inactiveTextColor ?? this.inactiveTextColor,
    );
  }

  @override
  ThemeExtension<NavTheme> lerp(
    covariant ThemeExtension<NavTheme>? other,
    double t,
  ) {
    if (other is! NavTheme) return this;
    return NavTheme(
      backgroundColor: Color.lerp(backgroundColor, other.backgroundColor, t)!,
      activeIconColor: Color.lerp(activeIconColor, other.activeIconColor, t)!,
      activeTextColor: Color.lerp(activeTextColor, other.activeTextColor, t)!,
      inactiveIconColor:
          Color.lerp(inactiveIconColor, other.inactiveIconColor, t)!,
      inactiveTextColor:
          Color.lerp(inactiveTextColor, other.inactiveTextColor, t)!,
    );
  }
}
