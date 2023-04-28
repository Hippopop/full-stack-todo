import 'package:flutter_riverpod/flutter_riverpod.dart';

final navigationProvider = Provider<NavbarManager>((ref) {
  return const NavbarManager();
});

class NavbarManager {
  static const List<String> pathList = [
    '/allTodo',
    '/filterTodo',
  ];

  int index(String path) => pathList.indexOf(path);
  String path(int index) => pathList[index];
  const NavbarManager();
}
