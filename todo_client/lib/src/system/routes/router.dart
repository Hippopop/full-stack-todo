
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:todo_client/src/features/homepage/controllers/navbar_controller.dart';
import 'package:todo_client/src/features/homepage/views/add_todo.dart';
import 'package:todo_client/src/features/homepage/views/filter_screen.dart';
import 'package:todo_client/src/features/homepage/views/homepage.dart';
import 'package:todo_client/src/features/homepage/views/todo_screen.dart';

final goRouterProvider = Provider<GoRouter>(
  (ref) {
    final navProvider = ref.watch(navigationProvider);
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
          pageBuilder: (context, state) =>
              // DismissibleDialog(child: const AddTodoCard())
              DialogPage(
            child: const AddTodoCard(),
            builder: (_) => const AddTodoCard(),
          )

          /* CustomTransitionPage(
            fullscreenDialog: false,
            barrierDismissible: true,
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) =>
                    ScaleTransition(
              scale: Tween<double>(begin: 1.5, end: 1.00).animate(
                CurvedAnimation(
                  parent: animation,
                  curve: const Interval(0.50, 1.00),
                ),
              ),
              child: child,
            ),
            child: ,
          ) */
          ,
        ),
      ],
    );
  },
);

/// A dialog page with Material entrance and exit animations, modal barrier color,
/// and modal barrier behavior (dialog is dismissible with a tap on the barrier).
class DialogPage<T> extends Page<T> {
  final Offset? anchorPoint;
  final Color? barrierColor;
  final bool barrierDismissible;
  final String? barrierLabel;
  final bool useSafeArea;
  final CapturedThemes? themes;
  final WidgetBuilder builder;
  final Widget child;

  const DialogPage({
    required this.child,
    required this.builder,
    this.anchorPoint,
    this.barrierColor = Colors.black54,
    this.barrierDismissible = true,
    this.barrierLabel,
    this.useSafeArea = true,
    this.themes,
    super.key,
    super.name,
    super.arguments,
    super.restorationId,
  });

  @override
  Route<T> createRoute(BuildContext context) =>
      // DismissibleDialog(child: child, routeSettings: this)
      /* DialogRoute<T>(
        context: context,
        // settings: this,
        builder: builder,
        anchorPoint: anchorPoint,
        barrierColor: barrierColor,
        barrierDismissible: barrierDismissible,
        barrierLabel: barrierLabel,
        useSafeArea: useSafeArea,
        themes: themes,
      ) */
      RawDialogRoute<T>(
        pageBuilder: (context, animation, secenderyAnimation) => child,
        settings: this,
        transitionDuration: const Duration(milliseconds: 350),
        transitionBuilder: (context, animation, secondaryAnimation, child) =>
            SlideTransition(
          position: Tween(
            begin: const Offset(0, 1),
            end: const Offset(0, 0),
          ).animate(animation),
          child: ScaleTransition(
            scale: Tween<double>(begin: 0, end: 1.00).animate(
              CurvedAnimation(
                parent: animation,
                curve: /* const Interval(0.50, 1.00) */ Curves.elasticOut,
              ),
            ),
            child: child,
          ),
        ),
      );
}

class AnimatedDialogue<T> extends RawDialogRoute<T> {
  AnimatedDialogue({
    required super.pageBuilder,
  });
  
}

class ActualDialogPage<T> extends Page<T> {
  final Offset? anchorPoint;
  final Color? barrierColor;
  final bool barrierDismissible;
  final String? barrierLabel;
  final bool useSafeArea;
  final CapturedThemes? themes;
  final WidgetBuilder builder;

  const ActualDialogPage({
    required this.builder,
    this.anchorPoint,
    this.barrierColor = Colors.black54,
    this.barrierDismissible = true,
    this.barrierLabel,
    this.useSafeArea = true,
    this.themes,
    super.key,
    super.name,
    super.arguments,
    super.restorationId,
  });

  @override
  Route<T> createRoute(BuildContext context) => DialogRoute<T>(
        context: context,
        settings: this,
        builder: builder,
        anchorPoint: anchorPoint,
        barrierColor: barrierColor,
        barrierDismissible: barrierDismissible,
        barrierLabel: barrierLabel,
        useSafeArea: useSafeArea,
        themes: themes,
      );
}

class DismissibleDialog<T> extends PopupRoute<T> {
  DismissibleDialog({
    required this.child,
    required this.routeSettings,
  });

  final Widget child;
  final RouteSettings routeSettings;

  @override
  Color? get barrierColor => Colors.black.withAlpha(0x50);

  // This allows the popup to be dismissed by tapping the scrim or by pressing
  // the escape key on the keyboard.
  @override
  bool get barrierDismissible => true;

  @override
  String? get barrierLabel => 'Dismissible Dialog';

  @override
  Duration get transitionDuration => const Duration(milliseconds: 300);

  @override
  RouteSettings get settings => routeSettings;

  @override
  Widget buildPage(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
  ) {
    return Center(
      // Provide DefaultTextStyle to ensure that the dialog's text style
      // matches the rest of the text in the app.
      child: DefaultTextStyle(
        style: Theme.of(context).textTheme.bodyMedium!,
        // UnconstrainedBox is used to make the dialog size itself
        // to fit to the size of the content.
        child: UnconstrainedBox(
          child: child,
        ),
      ),
    );
  }
}
