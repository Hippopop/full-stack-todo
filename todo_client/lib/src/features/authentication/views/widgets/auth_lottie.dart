import 'package:lottie/lottie.dart';
import 'package:flutter/material.dart';
import 'package:todo_client/src/constants/assets/lottie.dart';

class AuthLottie extends StatefulWidget {
  const AuthLottie({
    super.key,
    this.dimension,
  });

  final double? dimension;
  @override
  State<AuthLottie> createState() => _AuthLottieState();
}

class _AuthLottieState extends State<AuthLottie>
    with SingleTickerProviderStateMixin {
  late final AnimationController animationController;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      vsync: this,
    );
  }

  _animate() {
    animationController.reset();
    animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => _animate(),
      child: GestureDetector(
        onTap: _animate,
        child: SizedBox.square(
          dimension: widget.dimension ?? 300,
          child: Lottie.asset(
            LottieAsset.authLottie,
            repeat: false,
            addRepaintBoundary: true,
            controller: animationController,
            onLoaded: (lottie) {
              animationController.duration = lottie.duration;
              _animate();
            },
          ),
        ),
      ),
    );
  }
}
