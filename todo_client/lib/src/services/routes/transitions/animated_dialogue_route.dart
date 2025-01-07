import 'package:flutter/material.dart';

class AnimatedDialogueBuilder<T> extends Page<T> {
  final Widget child;
  final Offset? anchorPoint;
  final Color? barrierColor;
  final bool barrierDismissible;
  final String? barrierLabel;
  final bool useSafeArea;
  final CapturedThemes? themes;

  const AnimatedDialogueBuilder({
    super.key,
    super.name,
    super.arguments,
    super.restorationId,
    this.themes,
    this.anchorPoint,
    this.barrierLabel,
    required this.child,
    this.useSafeArea = true,
    this.barrierDismissible = true,
    this.barrierColor = Colors.black54,
  });

  @override
  Route<T> createRoute(BuildContext context) => RawDialogRoute<T>(
        settings: this,
        anchorPoint: anchorPoint,
        barrierLabel: barrierLabel,
        barrierColor: barrierColor,
        barrierDismissible: barrierDismissible,
        pageBuilder: (_, __, ___) => child,
        transitionDuration: const Duration(milliseconds: 350),
        transitionBuilder: (_, animation, __, child) => SlideTransition(
          position: Tween(
            end: const Offset(0, 0),
            begin: const Offset(0, 1),
          ).animate(animation),
          child: ScaleTransition(
            scale: Tween<double>(begin: 0, end: 1.00).animate(
              CurvedAnimation(
                parent: animation,
                curve: Curves.elasticOut,
              ),
            ),
            child: child,
          ),
        ),
      );
}
