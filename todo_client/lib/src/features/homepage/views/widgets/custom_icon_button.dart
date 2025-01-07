import 'package:flutter/material.dart';

class CustomIconButton extends StatefulWidget {
  const CustomIconButton({
    super.key,
    this.height,
    this.width,
    this.style,
    this.textStyle,
    this.onPressed,
    required this.icon,
    required this.text,
  });

  final String text;
  final Widget icon;

  final double? height;
  final double? width;
  final TextStyle? textStyle;
  final ButtonStyle? style;
  final VoidCallback? onPressed;

  @override
  State<CustomIconButton> createState() => _CustomIconButtonState();
}

class _CustomIconButtonState extends State<CustomIconButton> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.height ?? double.infinity,
      width: widget.width ?? double.infinity,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: ElevatedButton.icon(
              onPressed: widget.onPressed,
              icon: widget.icon,
              label: Text(
                widget.text,
                style: widget.textStyle,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
