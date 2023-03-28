import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_client/src/features/homepage/controllers/navbar_controller.dart';
import 'package:todo_client/src/my_app.dart';

class NavigationBarWidget extends ConsumerWidget {
  const NavigationBarWidget({
    super.key,
    required this.currentPath,
  });

  final String currentPath;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final navbarManager = ref.watch(navigationProvider);
    final navTheme = Theme.of(context).extension<NavTheme>();
    return BottomAppBar(
      notchMargin: 6,
      clipBehavior: Clip.hardEdge,
      shape: const CircularNotchedRectangle(),
      child: SafeArea(
        child: BottomNavigationBar(
          backgroundColor: navTheme?.backgroundColor,
          currentIndex: navbarManager.index(currentPath),
          onTap: (value) {
            context.go(navbarManager.path(value));
          },
          selectedItemColor: navTheme?.activeIconColor,
          unselectedItemColor: navTheme?.inactiveIconColor,
          selectedLabelStyle: TextStyle(
            color: navTheme?.activeTextColor,
            fontSize: 14,
            fontWeight: FontWeight.w700,
          ),
          unselectedLabelStyle: TextStyle(
            color: navTheme?.inactiveTextColor,
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
          items: const [
            BottomNavigationBarItem(
              activeIcon: Icon(Icons.home),
              icon: Icon(Icons.home_work),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              activeIcon: Icon(Icons.shopify),
              icon: Icon(Icons.shopping_bag),
              label: 'Cart',
            ),
          ],
        ),
      ),
    );
  }
}
