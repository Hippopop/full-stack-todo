import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:todo_client/src/features/homepage/controllers/navbar_controller.dart';
import 'package:todo_client/src/features/homepage/views/add_todo.dart';
import 'package:todo_client/src/features/homepage/views/filter_screen.dart';
import 'package:todo_client/src/features/homepage/views/homepage.dart';
import 'package:todo_client/src/features/homepage/views/todo_screen.dart';
import 'package:todo_client/src/repository/repository.dart';

import 'transitions/animated_dialogue_route.dart';

final goRouterProvider = Provider<GoRouter>(
  (ref) {
    final navProvider = ref.watch(navigationProvider);

    final req = ref.watch(requestHandlerProvider); 
    final rootNavigatorKey = GlobalKey<NavigatorState>(debugLabel: '#root');
    final shellNavigatorKey = GlobalKey<NavigatorState>(debugLabel: '#shell');

    return GoRouter(
      debugLogDiagnostics: true,
      initialLocation: '/allTodo',
      navigatorKey: rootNavigatorKey,
      routes: [
        ShellRoute(
          navigatorKey: shellNavigatorKey,
          builder: (context, state, child) => HomePage(
            currentChild: child,
            childPath: state.subloc,
          ),
          routes: [
            GoRoute(
              parentNavigatorKey: shellNavigatorKey,
              path: navProvider.path(0),
              builder: (context, state) => const AllTodoScreen(),
            ),
            GoRoute(
              parentNavigatorKey: shellNavigatorKey,
              path: navProvider.path(1),
              builder: (context, state) => const FilterTodoScreen(),
            ),
          ],
        ),
        GoRoute(
          path: '/outside',
          parentNavigatorKey: rootNavigatorKey,
          pageBuilder: (context, state) => const AnimatedDialogueBuilder(
            child: AddTodoCard(),
          ),
        ),
      ],
    );
  },
);
