import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'widgets/navbar.dart';

class HomePage extends StatelessWidget {
  const HomePage({
    super.key,
    required this.currentChild,
    required this.childPath,
  });
  final Widget currentChild;
  final String childPath;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: currentChild,
      extendBody: true,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.push('/outside'),
        child: const Icon(
          Icons.add, 
        ),
      ),
      bottomNavigationBar: NavigationBarWidget(
        currentPath: childPath,
      ),
    );
  }
}
