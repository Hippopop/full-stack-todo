import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_client/src/features/authentication/views/login_screen.dart';
import 'package:todo_client/src/features/authentication/views/registration_screen.dart';

import 'package:todo_client/src/features/homepage/views/add_todo.dart';
import 'package:todo_client/src/features/homepage/views/filter_screen.dart';
import 'package:todo_client/src/features/homepage/views/homepage.dart';
import 'package:todo_client/src/features/homepage/views/todo_screen.dart';

import 'transitions/animated_dialogue_route.dart';

final goRouterProvider = Provider<GoRouter>(
  (ref) {
    final rootNavigatorKey = GlobalKey<NavigatorState>(debugLabel: '#root');
    final shellNavigatorKey = GlobalKey<NavigatorState>(debugLabel: '#shell');

    return GoRouter(
      debugLogDiagnostics: true,
      initialLocation: LoginScreen.route,
      navigatorKey: rootNavigatorKey,
      routes: [
        ShellRoute(
          navigatorKey: shellNavigatorKey,
          builder: (context, state, child) => HomePage(
            currentChild: child,
            childPath: state.matchedLocation,
          ),
          routes: [
            GoRoute(
              parentNavigatorKey: shellNavigatorKey,
              path: AllTodoScreen.route,
              builder: (context, state) => const AllTodoScreen(),
            ),
            GoRoute(
              parentNavigatorKey: shellNavigatorKey,
              path: FilterTodoScreen.route,
              builder: (context, state) => const FilterTodoScreen(),
            ),
          ],
        ),
        GoRoute(
          path: AddTodoCard.route,
          parentNavigatorKey: rootNavigatorKey,
          pageBuilder: (context, state) => const AnimatedDialogueBuilder(
            child: AddTodoCard(),
          ),
        ),
        GoRoute(
          path: LoginScreen.route,
          parentNavigatorKey: rootNavigatorKey,
          builder: (context, state) => const LoginScreen(),
        ),
        GoRoute(
          path: RegistrationScreen.route,
          parentNavigatorKey: rootNavigatorKey,
          builder: (context, state) => const RegistrationScreen(),
        ),
      ],
    );
  },
);
