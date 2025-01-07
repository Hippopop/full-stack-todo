// MIT License
//
// Copyright (c) 2024 [Mostafijul Islam]
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.

import 'package:flutter/material.dart';

// ignore: non_constant_identifier_names
final _SCAFFOLD_KEY = GlobalKey<ScaffoldMessengerState>();

typedef SnackbarBuilderFunction = Widget Function({
  required BuildContext context,
  required CustomSnackbarType type,
  required SnackbarColorTheme color,
  required IconData icon,
  required String title,
  required String description,
});

enum CustomSnackbarType {
  info,
  error,
  warning,
  success,
}

class SnackbarUtil {
  SnackbarUtil._();
  static final SnackbarUtil _factory = SnackbarUtil._();
  static SnackbarUtil instance = _factory;

  GlobalKey<ScaffoldMessengerState> get key => _SCAFFOLD_KEY;

  static showToast({
    Duration? duration,
    required String title,
    required String description,
    required IconData iconData,
    required CustomSnackbarType snackbarType,
    SnackbarBuilderFunction? snackbarBuilder,
  }) {
    _SCAFFOLD_KEY.currentState?.showSnackBar(
      SnackBar(
        elevation: 0,
        margin: EdgeInsets.zero,
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.transparent,
        duration: duration ?? const Duration(seconds: 3),
        content: Builder(
          builder: (context) {
            final theme = context.snackbarThemeUtil;
            final builder = theme.snackbarBuilder;
            final colors = switch (snackbarType) {
              CustomSnackbarType.info => theme.info,
              CustomSnackbarType.error => theme.error,
              CustomSnackbarType.warning => theme.warning,
              CustomSnackbarType.success => theme.success,
            };
            return snackbarBuilder?.call(
                    color: colors,
                    context: context,
                    description: description,
                    icon: iconData,
                    title: title,
                    type: snackbarType) ??
                builder?.call(
                    color: colors,
                    context: context,
                    description: description,
                    icon: iconData,
                    title: title,
                    type: snackbarType) ??
                _DefaultRRectSnackbarWidget(
                  icon: iconData,
                  desc: description,
                  title: title,
                  colors: colors,
                );
          },
        ),
      ),
    );
  }

  static hideToast() {
    _SCAFFOLD_KEY.currentState?.hideCurrentSnackBar();
  }
}

extension SnackbarUtilExtension on BuildContext {
  SnackbarUtilTheme get snackbarThemeUtil =>
      Theme.of(this).extension<SnackbarUtilTheme>() ?? SnackbarUtilTheme();
}

/// Theme extension for the [SnackbarUtil] system!
class SnackbarUtilTheme extends ThemeExtension<SnackbarUtilTheme> {
  final SnackbarColorTheme info;
  final SnackbarColorTheme error;
  final SnackbarColorTheme warning;
  final SnackbarColorTheme success;

  final SnackbarBuilderFunction? snackbarBuilder;

  SnackbarUtilTheme({
    this.snackbarBuilder,
    this.info = const SnackbarColorTheme(
      border: Colors.blue,
      mainIcon: Colors.white,
      titleText: Colors.black,
      cancelIcon: Colors.grey,
      background: Color(0xFFBBDEFB),
      iconBackground: Colors.blue,
      descriptionText: Color(0xFF424242),
    ),
    this.error = const SnackbarColorTheme(
      border: Colors.red,
      mainIcon: Colors.white,
      titleText: Colors.black,
      cancelIcon: Colors.grey,
      iconBackground: Colors.red,
      background: Color(0xFFFFCDD2),
      descriptionText: Color(0xFF424242),
    ),
    this.warning = const SnackbarColorTheme(
      border: Colors.orange,
      mainIcon: Colors.white,
      titleText: Colors.black,
      cancelIcon: Colors.grey,
      background: Color(0xFFFFE0B2),
      iconBackground: Colors.orange,
      descriptionText: Color(0xFF424242),
    ),
    this.success = const SnackbarColorTheme(
      border: Colors.green,
      mainIcon: Colors.white,
      titleText: Colors.black,
      cancelIcon: Colors.grey,
      background: Color(0xFFB9F6CA),
      iconBackground: Color(0xFF00E676),
      descriptionText: Color(0xFF424242),
    ),
  });

  @override
  ThemeExtension<SnackbarUtilTheme> copyWith({
    SnackbarColorTheme? info,
    SnackbarColorTheme? error,
    SnackbarColorTheme? warning,
    SnackbarColorTheme? success,
    SnackbarBuilderFunction? snackbarBuilder,
  }) {
    return SnackbarUtilTheme(
      info: info ?? this.info,
      error: error ?? this.error,
      warning: warning ?? this.warning,
      success: success ?? this.success,
      snackbarBuilder: snackbarBuilder ?? this.snackbarBuilder,
    );
  }

  @override
  ThemeExtension<SnackbarUtilTheme> lerp(
    covariant ThemeExtension<SnackbarUtilTheme>? other,
    double t,
  ) {
    if (other is! SnackbarUtilTheme) return this;
    return SnackbarUtilTheme(
      snackbarBuilder: other.snackbarBuilder,
      info: info.lerp(other.info, t) as SnackbarColorTheme,
      error: error.lerp(other.error, t) as SnackbarColorTheme,
      warning: warning.lerp(other.warning, t) as SnackbarColorTheme,
      success: success.lerp(other.success, t) as SnackbarColorTheme,
    );
  }
}

class SnackbarColorTheme extends ThemeExtension<SnackbarColorTheme> {
  final Color border;
  final Color mainIcon;
  final Color titleText;
  final Color background;
  final Color cancelIcon;
  final Color iconBackground;
  final Color descriptionText;

  const SnackbarColorTheme({
    required this.border,
    required this.mainIcon,
    required this.titleText,
    required this.cancelIcon,
    required this.background,
    required this.iconBackground,
    required this.descriptionText,
  });

  @override
  ThemeExtension<SnackbarColorTheme> copyWith({
    Color? border,
    Color? mainIcon,
    Color? titleText,
    Color? cancelIcon,
    Color? background,
    Color? iconBackground,
    Color? descriptionText,
    CustomSnackbarType? snackbarType,
  }) {
    return SnackbarColorTheme(
      border: border ?? this.border,
      mainIcon: mainIcon ?? this.mainIcon,
      titleText: titleText ?? this.titleText,
      cancelIcon: cancelIcon ?? this.cancelIcon,
      background: background ?? this.background,
      iconBackground: iconBackground ?? this.iconBackground,
      descriptionText: descriptionText ?? this.descriptionText,
    );
  }

  @override
  ThemeExtension<SnackbarColorTheme> lerp(
    covariant ThemeExtension<SnackbarColorTheme>? other,
    double t,
  ) {
    if (other is! SnackbarColorTheme) return this;
    return SnackbarColorTheme(
      border: Color.lerp(border, other.border, t)!,
      mainIcon: Color.lerp(mainIcon, other.mainIcon, t)!,
      titleText: Color.lerp(titleText, other.titleText, t)!,
      cancelIcon: Color.lerp(cancelIcon, other.cancelIcon, t)!,
      background: Color.lerp(background, other.background, t)!,
      iconBackground: Color.lerp(iconBackground, other.iconBackground, t)!,
      descriptionText: Color.lerp(descriptionText, other.descriptionText, t)!,
    );
  }
}

/// The base default snackbar widget.
class _DefaultRRectSnackbarWidget extends StatelessWidget {
  const _DefaultRRectSnackbarWidget({
    required this.icon,
    required this.desc,
    required this.title,
    required this.colors,
  });

  final String desc;
  final String title;
  final IconData icon;
  final SnackbarColorTheme colors;

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(
        maxWidth: 940,
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 0),
        decoration: BoxDecoration(
          color: colors.background,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: colors.border,
          ),
        ),
        child: Row(
          children: [
            Expanded(
              flex: 2,
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: colors.iconBackground,
                ),
                padding: const EdgeInsets.all(10),
                child: Icon(
                  icon,
                  color: colors.mainIcon,
                  size: 20,
                ),
              ),
            ),
            const SizedBox(width: 5),
            Expanded(
              flex: 7,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 16,
                      height: 1,
                      color: colors.titleText,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 5.0),
                  Text(
                    desc,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: 14,
                      color: colors.descriptionText,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 5),
            Expanded(
              flex: 2,
              child: Center(
                child: InkWell(
                  onTap: () => SnackbarUtil.hideToast(),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: const EdgeInsets.all(10),
                    child: Icon(
                      Icons.cancel_outlined,
                      color: colors.cancelIcon,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

showToastError(String desc, [String? title, IconData? icon]) {
  SnackbarUtil.showToast(
    description: desc,
    title: title ?? "Error!",
    iconData: icon ?? Icons.error_outline_rounded,
    snackbarType: CustomSnackbarType.error,
  );
}

showToastInfo(String desc, [String? title, IconData? icon]) {
  SnackbarUtil.showToast(
    description: desc,
    title: title ?? "Wait!",
    iconData: icon ?? Icons.info_outline_rounded,
    snackbarType: CustomSnackbarType.info,
  );
}

showToastWarning(String desc, [String? title, IconData? icon]) {
  SnackbarUtil.showToast(
    description: desc,
    title: title ?? "Warning!",
    iconData: icon ?? Icons.warning_amber_rounded,
    snackbarType: CustomSnackbarType.warning,
  );
}

showToastSuccess(String desc, [String? title, IconData? icon]) {
  SnackbarUtil.showToast(
    description: desc,
    title: title ?? "Congratulations!",
    iconData: icon ?? Icons.celebration_outlined,
    snackbarType: CustomSnackbarType.success,
  );
}
