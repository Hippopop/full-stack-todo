import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo_client/src/constants/design/border_radius.dart';
import 'package:todo_client/src/constants/design/paddings.dart';
import 'package:todo_client/src/system/themes/extensions/extension_themes.dart';

part './default_input_decoration.dart';
part './default_text_styles.dart';
part './toned_checkbox.dart';

const _theme = Colors.white;
const _opposite = Colors.black;
const _extraColor = Color(0xffF8B6C0);
const _mainAccent = Color(0xffF2B872);
const _primaryColor = Color(0xff3084F2);
const _primaryAccent = Color(0xff96D9A0);
const _extraTextColor = Color(0xff3B3C40);
const _secondaryAccent = Color(0xffA0ACF2);
const _backgroundColor = Color(0xffF2F2F2);

const _errorState = Colors.red;

// Started from auth.
const _borderGreyColor = Color(0xffC6C6C6);
const _primaryTwoColor = Color(0xff4E0189);
final _subtleText = const Color(0xff1F1F1F).withOpacity(0.4);

final lightTheme = ThemeData(
  useMaterial3: false,
  brightness: Brightness.light,
  textTheme: TextTheme(
    labelMedium: _manropeLabelMidium,
    headlineMedium: _manropeHeadlineMidium,
  ),
  dividerTheme: const DividerThemeData(
    color: _borderGreyColor,
    thickness: 1,
  ),
  iconButtonTheme: IconButtonThemeData(
    style: IconButton.styleFrom(
      visualDensity: VisualDensity.compact,
      padding: emptyPadding,
      minimumSize: Size.zero,
      elevation: 3,
      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
    ),
  ),
  outlinedButtonTheme: OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      foregroundColor: _opposite,
      padding: vertical10,
      textStyle: _manropeLabelLarge.copyWith(color: _opposite),
      shape: const RoundedRectangleBorder(
        borderRadius: br10,
      ),
    ),
  ),
  filledButtonTheme: FilledButtonThemeData(
    style: FilledButton.styleFrom(
      backgroundColor: _primaryTwoColor,
      textStyle: _manropeLabelLarge.copyWith(color: _theme),
      shape: const RoundedRectangleBorder(
        borderRadius: br10,
      ),
    ),
  ),
  inputDecorationTheme: defaultInputDecoration,
  checkboxTheme: tonedCheckboxTheme,
  progressIndicatorTheme: const ProgressIndicatorThemeData(color: _theme),
  colorScheme: ColorScheme.fromSeed(seedColor: _primaryColor),
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
      borderGreyColor: _borderGreyColor,
      mainSecondBatch: _primaryTwoColor,
      errorState: _errorState,
      secondaryText: _subtleText,
    ),
  },
);
