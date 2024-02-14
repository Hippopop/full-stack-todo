import 'package:flutter/material.dart';

typedef TextWidgetBuilder = Widget Function(String text);

class AnimatedBuildText extends StatefulWidget {
  const AnimatedBuildText(
    this.text, {
    super.key,
    this.duration,
    this.textBuilder,
  });
  final String text;
  final Duration? duration;
  final TextWidgetBuilder? textBuilder;

  @override
  State<AnimatedBuildText> createState() => _AnimatedBuildTextState();
}

class _AnimatedBuildTextState extends State<AnimatedBuildText>
    with SingleTickerProviderStateMixin {
  String text = "";
  String? oldText;
  late final CurvedAnimation animation;
  late final AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: widget.duration ?? Durations.medium2,
    );

    animation = CurvedAnimation(
      parent: Tween<double>(
        begin: 0,
        end: 1,
      ).animate(controller),
      curve: Curves.bounceIn,
      reverseCurve: Curves.bounceOut,
    );
    animation.addListener(_buildText);
    controller.forward();
  }

  _buildText() {
    setState(() {
      if (oldText != null) {
        if (animation.value <= 0.5) {
          final value = (0.5 - animation.value) * 2;
          final letterPosition = (value * oldText!.length).toInt();
          text = oldText!.substring(0, letterPosition);
        } else {
          final value = (animation.value - 0.5) * 2;
          final letterPosition = (value * widget.text.length).toInt();
          text = widget.text.substring(0, letterPosition);
        }
      } else {
        final letterPosition = ((animation.value) * widget.text.length).toInt();
        text = widget.text.substring(0, letterPosition);
      }
    });
  }

  @override
  void didUpdateWidget(covariant AnimatedBuildText oldWidget) {
    if (oldWidget.text != widget.text) {
      oldText = oldWidget.text;
      controller.reset();
      controller.forward();
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    controller.removeListener(_buildText);
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        return widget.textBuilder?.call(text) ?? Text(text);
      },
    );
  }
}
