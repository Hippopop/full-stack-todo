import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_client/src/features/homepage/controllers/navbar_controller.dart';
import 'package:todo_client/src/system/themes/extensions/theme_extensions.dart';

class NavigationBarWidget extends ConsumerWidget {
  const NavigationBarWidget({
    super.key,
    required this.currentPath,
  });

  final String currentPath;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final navbarManager = ref.watch(navigationProvider);
    final colorTheme = Theme.of(context).extension<ColorsTheme>();
    return BottomAppBar(
      elevation: 0,
      notchMargin: 6,
      clipBehavior: Clip.hardEdge,
      shape: const CircularNotchedRectangle(),
      child: BottomNavigationBar(
        showUnselectedLabels: false,
        backgroundColor: colorTheme?.white,
        selectedItemColor: colorTheme?.primaryColor,
        currentIndex: navbarManager.index(currentPath),
        unselectedItemColor: colorTheme?.extraTextColor,
        onTap: (value) => context.go(navbarManager.path(value)),
        selectedLabelStyle: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w700,
          color: colorTheme?.primaryColor,
        ),
        unselectedLabelStyle: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w500,
          color: colorTheme?.extraTextColor,
        ),
        items: const [
          BottomNavigationBarItem(
            activeIcon: Icon(Icons.task_alt_rounded),
            icon: Icon(Icons.task_alt_rounded),
            label: 'TODOs',
          ),
          BottomNavigationBarItem(
            activeIcon: Icon(Icons.filter_alt_rounded),
            icon: Icon(Icons.filter_alt_rounded),
            label: 'Filter',
          ),
        ],
      ),
    );
  }
}
