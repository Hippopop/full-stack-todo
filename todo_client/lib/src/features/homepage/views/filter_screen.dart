import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:todo_client/src/system/themes/app_theme.dart';

class FilterTodoScreen extends StatelessWidget {
  const FilterTodoScreen({super.key});

  static const route = "/filterTodo";

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ConstrainedBox(
            constraints: const BoxConstraints(
              maxWidth: 640,
            ),
            child: Lottie.asset(
              'assets/lottie/underdevelopment.json',
            ),
          ),
          Text(
            'UNDER DEVELOPMENT',
            style: context.text.headlineMedium,
          ),
        ],
      ),
    );
  }
}
