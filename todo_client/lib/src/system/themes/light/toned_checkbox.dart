part of 'package:todo_client/src/system/themes/light/light_theme.dart';

final tonedCheckboxTheme = CheckboxThemeData(
  visualDensity: VisualDensity.compact,
  side: const BorderSide(
    color: _borderGreyColor,
    width: 1,
  ),
  checkColor: const MaterialStatePropertyAll(_opposite),
  fillColor: MaterialStateProperty.resolveWith((states) {
    if (states.contains(MaterialState.disabled)) {
      return _extraColor;
    }
    if (states.contains(MaterialState.selected)) {
      return _primaryAccent;
    }
    if (states.contains(MaterialState.focused)) {
      return _extraColor.withOpacity(0.1);
    }
    if (states.contains(MaterialState.hovered)) {
      return _primaryAccent.withOpacity(0.1);
    }
    return null;
  }),
  shape: const RoundedRectangleBorder(borderRadius: br4),
);
