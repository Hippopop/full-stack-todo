import 'package:flutter/material.dart';
import 'package:todo_client/src/system/themes/app_theme.dart';

import 'widgets/auth_lottie.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});
  static const route = "/auth";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) => const Column(
          children: [
            AuthLockRiveWidget(),
          ],
        ),
      ),
    );
  }
}

class AuthLockRiveWidget extends StatefulWidget {
  const AuthLockRiveWidget({
    super.key,
  });

  @override
  State<AuthLockRiveWidget> createState() => _AuthLockRiveWidgetState();
}

class _AuthLockRiveWidgetState extends State<AuthLockRiveWidget> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const AuthIntroPart(),
              TextFormField(),
              const SizedBox(height: 8),
              TextFormField(),
              const SizedBox(height: 8),
              ElevatedButton(
                onPressed: () {},
                child: const Text(
                  "Login",
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class AuthIntroPart extends StatelessWidget {
  const AuthIntroPart({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const AuthLottie(),
          Text(
            "Hey there!",
            style: context.text.headlineMedium?.copyWith(
              color: context.color?.primary,
            ),
          ),
          Text(
            "Hey there!",
            style: context.text.headlineMedium?.copyWith(
              color: context.color?.primary,
            ),
          ),
        ],
      ),
    );
  }
}
