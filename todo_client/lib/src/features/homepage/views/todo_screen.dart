import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lottie/lottie.dart';
import 'package:rive/rive.dart';
import 'package:todo_client/src/constants/assets/images/images.dart';
import 'package:todo_client/src/constants/server/api_config.dart';
import 'package:todo_client/src/constants/utils/date_formats.dart';
import 'package:todo_client/src/features/homepage/controllers/todo_controller.dart';
import 'package:todo_client/src/repository/repository.dart';
import 'package:todo_client/src/system/auth/auth_controller.dart';
import 'package:todo_client/src/system/themes/app_theme.dart';

import 'widgets/single_todo_widget.dart';

class AllTodoScreen extends StatelessWidget {
  const AllTodoScreen({super.key});

  static const route = "/allTodo";

  final titleTextStyles = const TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.bold,
  );

  @override
  Widget build(BuildContext context) {
    final colorTheme = Theme.of(context).extension<ColorTheme>();
    return ColoredBox(
      color: colorTheme?.mainBackground ?? Colors.white70,
      child: SafeArea(
        child: Column(
          children: [
            TodoScreenAppBar(colorTheme: colorTheme),
            Expanded(
              child: Container(
                width: double.infinity,
                margin: const EdgeInsets.only(
                    left: 16, right: 16, top: 0, bottom: 40),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: colorTheme?.theme,
                  borderRadius: BorderRadius.circular(24),
                ),
                constraints: const BoxConstraints(
                  maxWidth: 980,
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0, bottom: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Completed',
                            style: titleTextStyles,
                          ),
                          TextButton(
                            onPressed: () {},
                            child: const Text(
                              'View More',
                              style: TextStyle(
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Expanded(
                      child: TODOListView(),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TODOListView extends ConsumerWidget {
  const TODOListView({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final todos = ref.watch(todosController);
    return todos.when(
      loading: () => const Center(
        child: RiveAnimation.network(
          'https://cdn.rive.app/animations/vehicles.riv',
        ),
      ),
      error: (error, trace) {
        return InkWell(
          onTap: () {
            ref.watch(todosController.notifier).getAllTodos();
          },
          child: Text(
            error.toString(),
          ),
        );
      },
      data: (todos) => todos.isEmpty
          ? const AstronautPlaceholder()
          : ListView.separated(
              itemCount: todos.length,
              separatorBuilder: (_, __) => const SizedBox(height: 2),
              itemBuilder: (context, index) => TODOCardWidget(
                todo: todos[index],
              ),
            ),
    );
  }
}

class AstronautPlaceholder extends StatelessWidget {
  const AstronautPlaceholder({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: 20,
      child: Padding(
        padding: const EdgeInsets.all(0),
        child: ConstrainedBox(
          constraints: const BoxConstraints(
            maxWidth: 640,
          ),
          child: Lottie.asset(
            'assets/lottie/astronaut.json',
            addRepaintBoundary: true,
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }
}

class LottieLoader extends StatelessWidget {
  const LottieLoader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(0),
      child: ConstrainedBox(
        constraints: const BoxConstraints(
          maxWidth: 500,
        ),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Lottie.asset(
            'assets/lottie/loader.json',
            addRepaintBoundary: true,
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }
}

class TodoScreenAppBar extends StatelessWidget {
  const TodoScreenAppBar({
    super.key,
    required this.colorTheme,
  });

  final ColorTheme? colorTheme;

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(
        maxWidth: 980,
      ),
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Consumer(builder: (context, ref, child) {
          final todoState = ref.watch(todosController);
          final authenticationState = ref.watch(authStateNotifierProvider);
          print(authenticationState.currentUser?.photo);
          return Row(
            children: [
              DecoratedBox(
                decoration: BoxDecoration(
                  color: colorTheme?.theme,
                  shape: BoxShape.circle,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(3.0),
                  child: CircleAvatar(
                    maxRadius: 32,
                    backgroundImage: const AssetImage(
                      AssetImages.boyProfile,
                    ),
                    foregroundImage:
                        (authenticationState.currentUser?.photo == null)
                            ? null
                            : NetworkImage(APIConfig.baseURl +
                                authenticationState.currentUser!.photo!),
                    backgroundColor: colorTheme?.mainAccent,
                  ),
                ),
              ),
              const SizedBox(width: 18),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Hello,',
                      style: context.theme.textTheme.bodyLarge?.copyWith(
                        color: colorTheme?.primaryText,
                      ),
                    ),
                    Text(
                      '${authenticationState.currentUser?.name}.',
                      style: context.theme.textTheme.titleLarge,
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    dayDate.format(DateTime.now()),
                    style: context.theme.textTheme.titleMedium,
                  ),
                  const SizedBox(height: 8),
                  todoState.when(
                    data: (data) => Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        CountWidget(
                          color: colorTheme?.primaryAccent ?? Colors.green,
                          data: "${data.where(
                                (element) => element.priority == Priority.low,
                              ).length}",
                        ),
                        CountWidget(
                          color: colorTheme?.mainAccent ?? Colors.yellow,
                          data: "${data.where(
                                (element) =>
                                    element.priority == Priority.medium,
                              ).length}",
                        ),
                        CountWidget(
                          color: colorTheme?.secondaryAccent ?? Colors.purple,
                          data: "${data.where(
                                (element) => element.priority == Priority.high,
                              ).length}",
                        ),
                      ],
                    ),
                    error: (error, stackTrace) => Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        CountWidget(
                          color: colorTheme?.primaryAccent ?? Colors.green,
                          data: "??",
                        ),
                        CountWidget(
                          color: colorTheme?.mainAccent ?? Colors.yellow,
                          data: "??",
                        ),
                        CountWidget(
                          color: colorTheme?.secondaryAccent ?? Colors.purple,
                          data: "??",
                        ),
                      ],
                    ),
                    loading: () => Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        CountWidget(
                          color: colorTheme?.primaryAccent ?? Colors.green,
                          data: "??",
                        ),
                        CountWidget(
                          color: colorTheme?.mainAccent ?? Colors.yellow,
                          data: "??",
                        ),
                        CountWidget(
                          color: colorTheme?.secondaryAccent ?? Colors.purple,
                          data: "??",
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          );
        }),
      ),
    );
  }
}

class CountWidget extends StatelessWidget {
  const CountWidget({
    super.key,
    required this.data,
    required this.color,
  });

  final String data;
  final Color color;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 6.0),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          DecoratedBox(
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
            ),
            child: const Padding(
              padding: EdgeInsets.all(4),
            ),
          ),
          const SizedBox(width: 8),
          Text(
            data,
            style: context.theme.textTheme.bodyLarge?.copyWith(
              height: 1,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}
