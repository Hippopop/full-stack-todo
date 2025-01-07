part of 'package:todo_client/src/services/themes/light/light_theme.dart';

final tonedCheckboxTheme = CheckboxThemeData(
  visualDensity: VisualDensity.compact,
  side: const BorderSide(
    color: _borderGreyColor,
    width: 1,
  ),
  checkColor: const WidgetStatePropertyAll(_opposite),
  fillColor: WidgetStateProperty.resolveWith((states) {
    if (states.contains(WidgetState.disabled)) {
      return _extraColor;
    }
    if (states.contains(WidgetState.selected)) {
      return _primaryAccent;
    }
    if (states.contains(WidgetState.focused)) {
      return _extraColor.withOpacity(0.1);
    }
    if (states.contains(WidgetState.hovered)) {
      return _primaryAccent.withOpacity(0.1);
    }
    return null;
  }),
  shape: const RoundedRectangleBorder(borderRadius: br4),
);
