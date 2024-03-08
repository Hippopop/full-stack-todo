import 'package:flutter/material.dart';

extension ColorExtension on BuildContext {
  ColorTheme get color =>
      Theme.of(this).extension<ColorTheme>() ?? ColorTheme();
}

class ColorTheme extends ThemeExtension<ColorTheme> {
  final Color extra;
  final Color theme;
  final Color opposite;

  final Color mainBackground;
  final Color primaryBackground;
  final Color secondaryBackground;

  final Color errorState;
  final Color warningState;
  final Color infoState;
  final Color successState;

  final Color mainText;
  final Color primaryText;
  final Color secondaryText;

  final Color main;
  final Color primary;
  final Color secondary;

  final Color mainSupport;
  final Color primarySupport;
  final Color borderGreyColor;

  final Color mainAccent;
  final Color primaryAccent;
  final Color secondaryAccent;

  final Color mainFirstBatch;
  final Color primaryFirstBatch;
  final Color secondaryFirstBatch;

  final Color mainSecondBatch;
  final Color primarySecondBatch;
  final Color secondarySecondBatch;

  final Color mainThirdBatch;
  final Color primaryThirdBatch;
  final Color secondaryThirdBatch;

  ColorTheme({
    this.extra = Colors.blueGrey,
    this.theme = Colors.blueGrey,
    this.opposite = Colors.blueGrey,
    this.mainBackground = Colors.blueGrey,
    this.primaryBackground = Colors.blueGrey,
    this.secondaryBackground = Colors.blueGrey,
    this.errorState = Colors.blueGrey,
    this.warningState = Colors.blueGrey,
    this.infoState = Colors.blueGrey,
    this.successState = Colors.blueGrey,
    this.mainText = Colors.blueGrey,
    this.primaryText = Colors.blueGrey,
    this.secondaryText = Colors.blueGrey,
    this.main = Colors.blueGrey,
    this.primary = Colors.blueGrey,
    this.secondary = Colors.blueGrey,
    this.mainSupport = Colors.blueGrey,
    this.primarySupport = Colors.blueGrey,
    this.borderGreyColor = Colors.blueGrey,
    this.mainAccent = Colors.blueGrey,
    this.primaryAccent = Colors.blueGrey,
    this.secondaryAccent = Colors.blueGrey,
    this.mainFirstBatch = Colors.blueGrey,
    this.primaryFirstBatch = Colors.blueGrey,
    this.secondaryFirstBatch = Colors.blueGrey,
    this.mainSecondBatch = Colors.blueGrey,
    this.primarySecondBatch = Colors.blueGrey,
    this.secondarySecondBatch = Colors.blueGrey,
    this.mainThirdBatch = Colors.blueGrey,
    this.primaryThirdBatch = Colors.blueGrey,
    this.secondaryThirdBatch = Colors.blueGrey,
  });

  @override
  ColorTheme copyWith({
    Color? extraColor,
    Color? themeColor,
    Color? oppositeColor,
    Color? mainBackgroundColor,
    Color? primaryBackgroundColor,
    Color? secondaryBackgroundColor,
    Color? errorStateColor,
    Color? warningStateColor,
    Color? infoStateColor,
    Color? successStateColor,
    Color? mainTextColor,
    Color? primaryTextColor,
    Color? secondaryTextColor,
    Color? mainColor,
    Color? primaryColor,
    Color? secondaryColor,
    Color? mainSupportColor,
    Color? primarySupportColor,
    Color? secondarySupportColor,
    Color? mainAccentColor,
    Color? primaryAccentColor,
    Color? secondaryAccentColor,
    Color? mainFirstBatchColor,
    Color? primaryFirstBatchColor,
    Color? secondaryFirstBatchColor,
    Color? mainSecondBatchColor,
    Color? primarySecondBatchColor,
    Color? secondarySecondBatchColor,
    Color? mainThirdBatchColor,
    Color? primaryThirdBatchColor,
    Color? secondaryThirdBatchColor,
  }) {
    return ColorTheme(
      extra: extraColor ?? extra,
      theme: themeColor ?? theme,
      opposite: oppositeColor ?? opposite,
      mainBackground: mainBackgroundColor ?? mainBackground,
      primaryBackground: primaryBackgroundColor ?? primaryBackground,
      secondaryBackground: secondaryBackgroundColor ?? secondaryBackground,
      errorState: errorStateColor ?? errorState,
      warningState: warningStateColor ?? warningState,
      infoState: infoStateColor ?? infoState,
      successState: successStateColor ?? successState,
      mainText: mainTextColor ?? mainText,
      primaryText: primaryTextColor ?? primaryText,
      secondaryText: secondaryTextColor ?? secondaryText,
      main: mainColor ?? main,
      primary: primaryColor ?? primary,
      secondary: secondaryColor ?? secondary,
      mainSupport: mainSupportColor ?? mainSupport,
      primarySupport: primarySupportColor ?? primarySupport,
      borderGreyColor: secondarySupportColor ?? borderGreyColor,
      mainAccent: mainAccentColor ?? mainAccent,
      primaryAccent: primaryAccentColor ?? primaryAccent,
      secondaryAccent: secondaryAccentColor ?? secondaryAccent,
      mainFirstBatch: mainFirstBatchColor ?? mainFirstBatch,
      primaryFirstBatch: primaryFirstBatchColor ?? primaryFirstBatch,
      secondaryFirstBatch: secondaryFirstBatchColor ?? secondaryFirstBatch,
      mainSecondBatch: mainSecondBatchColor ?? mainSecondBatch,
      primarySecondBatch: primarySecondBatchColor ?? primarySecondBatch,
      secondarySecondBatch: secondarySecondBatchColor ?? secondarySecondBatch,
      mainThirdBatch: mainThirdBatchColor ?? mainThirdBatch,
      primaryThirdBatch: primaryThirdBatchColor ?? primaryThirdBatch,
      secondaryThirdBatch: secondaryThirdBatchColor ?? secondaryThirdBatch,
    );
  }

  @override
  ThemeExtension<ColorTheme> lerp(
    covariant ThemeExtension<ColorTheme>? other,
    double t,
  ) {
    if (other is! ColorTheme) return this;

    return ColorTheme(
      extra: Color.lerp(
        extra,
        other.extra,
        t,
      )!,
      theme: Color.lerp(
        theme,
        other.theme,
        t,
      )!,
      opposite: Color.lerp(
        opposite,
        other.opposite,
        t,
      )!,
      mainBackground: Color.lerp(
        mainBackground,
        other.mainBackground,
        t,
      )!,
      primaryBackground: Color.lerp(
        primaryBackground,
        other.primaryBackground,
        t,
      )!,
      secondaryBackground: Color.lerp(
        secondaryBackground,
        other.secondaryBackground,
        t,
      )!,
      errorState: Color.lerp(
        errorState,
        other.errorState,
        t,
      )!,
      warningState: Color.lerp(
        warningState,
        other.warningState,
        t,
      )!,
      infoState: Color.lerp(
        infoState,
        other.infoState,
        t,
      )!,
      successState: Color.lerp(
        successState,
        other.successState,
        t,
      )!,
      mainText: Color.lerp(
        mainText,
        other.mainText,
        t,
      )!,
      primaryText: Color.lerp(
        primaryText,
        other.primaryText,
        t,
      )!,
      secondaryText: Color.lerp(
        secondaryText,
        other.secondaryText,
        t,
      )!,
      main: Color.lerp(
        main,
        other.main,
        t,
      )!,
      primary: Color.lerp(
        primary,
        other.primary,
        t,
      )!,
      secondary: Color.lerp(
        secondary,
        other.secondary,
        t,
      )!,
      mainSupport: Color.lerp(
        mainSupport,
        other.mainSupport,
        t,
      )!,
      primarySupport: Color.lerp(
        primarySupport,
        other.primarySupport,
        t,
      )!,
      borderGreyColor: Color.lerp(
        borderGreyColor,
        other.borderGreyColor,
        t,
      )!,
      mainAccent: Color.lerp(
        mainAccent,
        other.mainAccent,
        t,
      )!,
      primaryAccent: Color.lerp(
        primaryAccent,
        other.primaryAccent,
        t,
      )!,
      secondaryAccent: Color.lerp(
        secondaryAccent,
        other.secondaryAccent,
        t,
      )!,
      mainFirstBatch: Color.lerp(
        mainFirstBatch,
        other.mainFirstBatch,
        t,
      )!,
      primaryFirstBatch: Color.lerp(
        primaryFirstBatch,
        other.primaryFirstBatch,
        t,
      )!,
      secondaryFirstBatch: Color.lerp(
        secondaryFirstBatch,
        other.secondaryFirstBatch,
        t,
      )!,
      mainSecondBatch: Color.lerp(
        mainSecondBatch,
        other.mainSecondBatch,
        t,
      )!,
      primarySecondBatch: Color.lerp(
        primarySecondBatch,
        other.primarySecondBatch,
        t,
      )!,
      secondarySecondBatch: Color.lerp(
        secondarySecondBatch,
        other.secondarySecondBatch,
        t,
      )!,
      mainThirdBatch: Color.lerp(
        mainThirdBatch,
        other.mainThirdBatch,
        t,
      )!,
      primaryThirdBatch: Color.lerp(
        primaryThirdBatch,
        other.primaryThirdBatch,
        t,
      )!,
      secondaryThirdBatch: Color.lerp(
        secondaryThirdBatch,
        other.secondaryThirdBatch,
        t,
      )!,
    );
  }
}
