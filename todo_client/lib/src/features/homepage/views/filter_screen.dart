import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lottie/lottie.dart';
import 'package:todo_client/src/constants/design/paddings.dart';
import 'package:todo_client/src/system/auth/auth_controller.dart';
import 'package:todo_client/src/system/themes/app_theme.dart';

class FilterTodoScreen extends StatelessWidget {
  const FilterTodoScreen({super.key});

  static const route = "/filterTodo";

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: Colors.white,
      child: Column(
        children: [
          Expanded(
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
          ),
          Consumer(builder: (context, ref, child) {
            return SafeArea(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: all20,
                    child: DecoratedBox(
                      decoration: const BoxDecoration(
                        color: Colors.black,
                        shape: BoxShape.circle,
                      ),
                      child: IconButton(
                        color: Colors.red,
                        onPressed: () async {
                          await ref
                              .watch(authStateNotifierProvider.notifier)
                              .logout();
                        },
                        icon: const Icon(
                          Icons.logout_outlined,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }
}
