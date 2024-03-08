part of 'package:todo_client/src/system/themes/light/light_theme.dart';

final defaultInputDecoration = InputDecorationTheme(
  filled: true,
  isCollapsed: false,
  fillColor: _theme,
  hintStyle: _manropeLabelMidium.copyWith(color: _subtleText),
  border: const OutlineInputBorder(
    borderRadius: br10,
    borderSide: BorderSide(
      color: _borderGreyColor,
    ),
  ),
  errorBorder: const OutlineInputBorder(
    borderRadius: br10,
    borderSide: BorderSide(
      color: Colors.red,
    ),
  ),
  errorStyle: GoogleFonts.manrope(),
  enabledBorder: const OutlineInputBorder(
    borderRadius: br10,
    borderSide: BorderSide(
      width: 0.5,
      color: _borderGreyColor,
    ),
  ),
  outlineBorder: const BorderSide(),
  focusedBorder: const OutlineInputBorder(
    borderRadius: br10,
    borderSide: BorderSide(
      color: _borderGreyColor,
    ),
  ),
  disabledBorder: const OutlineInputBorder(
    borderRadius: br10,
  ),
  focusedErrorBorder: const OutlineInputBorder(
    borderRadius: br10,
  ),
  isDense: true,
  contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
);
