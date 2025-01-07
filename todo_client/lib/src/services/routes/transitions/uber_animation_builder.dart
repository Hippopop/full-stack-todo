import 'dart:math';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// Wrapper for the whole animation for the custom page transition.
class UberTransitionBuilder extends CustomTransitionPage {
  const UberTransitionBuilder._({
    super.key,
    required super.child,
    required super.transitionsBuilder,
    required super.transitionDuration,
    required super.reverseTransitionDuration,
  });

  factory UberTransitionBuilder.build({
    Key? builderKey,
    LocalKey? pageKey,
    required Widget child,
  }) {
    return UberTransitionBuilder._(
      key: pageKey,
      child: child,
      transitionDuration: Durations.extralong4,
      reverseTransitionDuration: Duration.zero,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return AnimatedBuilder(
          animation: animation,
          builder: (context, __) {
            return _UberAnimationBuilder(
              key: builderKey,
              animation: animation.value,
              child: child,
            );
          },
        );
      },
    );
  }
}

/// Animated widget builder containing the custom painter for the animation.
class _UberAnimationBuilder extends StatelessWidget {
  const _UberAnimationBuilder({
    super.key,
    required this.child,
    required this.animation,
  });

  final Widget child;
  final double animation;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      foregroundPainter: _UberAnimationPainter(
        animationValue: animation,
      ),
      child: child,
    );
  }
}

/// Custom painter for the animation.
class _UberAnimationPainter extends CustomPainter {
  final double animationValue;
  _UberAnimationPainter({
    required this.animationValue,
  });
  @override
  void paint(Canvas canvas, Size size) {
    final percentage = 1 - animationValue;
    final bluePaint = Paint()
      ..color = Colors.blue.withOpacity(0.5)
      ..style = PaintingStyle.fill;
    final blackPaint = Paint()
      ..color = Colors.black.withOpacity((percentage - 0.3).clamp(0, 1))
      ..style = PaintingStyle.fill;
    final center = Offset(size.width / 2, size.height / 2);
    final biggestCenter = max(center.dx, center.dy);
    canvas.drawCircle(center, biggestCenter * percentage, blackPaint);
    canvas.drawCircle(center, biggestCenter * percentage * 0.7, bluePaint);
    canvas.drawCircle(center, biggestCenter * percentage * 0.5, bluePaint);
  }

  @override
  bool shouldRepaint(covariant _UberAnimationPainter oldDelegate) {
    return animationValue != oldDelegate.animationValue;
  }
}
