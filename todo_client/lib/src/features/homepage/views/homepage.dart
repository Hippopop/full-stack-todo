import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_client/src/system/themes/extensions/theme_extensions.dart';

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
    final theme = Theme.of(context).extension<ColorsTheme>();
    return Scaffold(
      extendBody: true,
      body: currentChild,
      backgroundColor: Colors.transparent,
      bottomNavigationBar: NavigationBarWidget(
        currentPath: childPath,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.push('/outside'),
        backgroundColor: theme?.primaryColor,
        elevation: 0,
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
