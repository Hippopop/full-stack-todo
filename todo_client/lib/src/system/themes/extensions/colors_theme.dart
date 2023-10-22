import 'package:flutter/material.dart';

extension ColorExtension on BuildContext {
  ColorTheme? get color => Theme.of(this).extension<ColorTheme>();
}

class ColorTheme extends ThemeExtension<ColorTheme> {
  final Color theme;
  final Color opposite;
  final Color extra;
  final Color mainAccent;
  final Color primary;
  final Color primaryAccent;
  final Color secondaryAccent;
  final Color extraText;
  final Color background;

  ColorTheme({
    required this.opposite,
    required this.theme,
    required this.extra,
    required this.mainAccent,
    required this.primary,
    required this.primaryAccent,
    required this.secondaryAccent,
    required this.extraText,
    required this.background,
  });

  @override
  ColorTheme copyWith({
    Color? oppositeColor,
    Color? themeColor,
    Color? mainAccentColor,
    Color? extraColor,
    Color? primaryColor,
    Color? primaryAccentColor,
    Color? secondaryAccentColor,
    Color? extraTextColor,
    Color? backgroundColor,
  }) {
    return ColorTheme(
      theme: oppositeColor ?? opposite,
      opposite: themeColor ?? theme,
      mainAccent: mainAccentColor ?? mainAccent,
      extra: extraColor ?? extra,
      primary: primaryColor ?? primary,
      primaryAccent: primaryAccentColor ?? primaryAccent,
      secondaryAccent: secondaryAccentColor ?? secondaryAccent,
      extraText: extraTextColor ?? extraText,
      background: backgroundColor ?? background,
    );
  }

  @override
  ThemeExtension<ColorTheme> lerp(
      covariant ThemeExtension<ColorTheme>? other, double t) {
    if (other is! ColorTheme) return this;
    return ColorTheme(
      theme: Color.lerp(theme, other.theme, t)!,
      opposite: Color.lerp(opposite, other.opposite, t)!,
      mainAccent: Color.lerp(mainAccent, other.mainAccent, t)!,
      extra: Color.lerp(extra, other.extra, t)!,
      primary: Color.lerp(primary, other.primary, t)!,
      primaryAccent: Color.lerp(primaryAccent, other.primaryAccent, t)!,
      secondaryAccent: Color.lerp(secondaryAccent, other.secondaryAccent, t)!,
      extraText: Color.lerp(extraText, other.extraText, t)!,
      background: Color.lerp(background, other.background, t)!,
    );
  }
}
