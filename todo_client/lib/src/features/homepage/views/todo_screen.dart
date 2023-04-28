import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lottie/lottie.dart';
import 'package:todo_client/src/domain/model/todo/todo.dart';
import 'package:todo_client/src/features/homepage/controllers/todo_provider.dart';
import 'package:todo_client/src/system/themes/extensions/theme_extensions.dart';

class AllTodoScreen extends StatelessWidget {
  const AllTodoScreen({super.key});

  final titleTextStyles = const TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.bold,
  );

  @override
  Widget build(BuildContext context) {
    final colorTheme = Theme.of(context).extension<ColorsTheme>();
    return ColoredBox(
      color: colorTheme?.backgroundColor ?? Colors.white70,
      child: MouseRegion(
        onHover: (PointerHoverEvent event) {},
        child: SafeArea(
          child: Column(
            children: [
              TODOScreenAppBar(colorTheme: colorTheme),
              Expanded(
                child: Container(
                  width: double.infinity,
                  margin: const EdgeInsets.only(
                      left: 16, right: 16, top: 0, bottom: 40),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: colorTheme?.white,
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
                      const Expanded(child: TODOListView())
                    ],
                  ),
                ),
              ),
            ],
          ),
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
    final todos = ref.watch(todosProvider);
    return ListView.separated(
      itemBuilder: (context, index) => TODOCardWidget(
        todo: todos[index],
      ),
      separatorBuilder: (_, __) => const SizedBox(height: 2),
      itemCount: todos.length,
    );
  }
}

class TODOCardWidget extends ConsumerWidget {
  const TODOCardWidget({
    super.key,
    required this.todo,
  });
  final Todo todo;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ColorsTheme? colorTheme = Theme.of(context).extension();
    return Card(
      color: colorTheme?.backgroundColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      clipBehavior: Clip.hardEdge,
      child: SizedBox(
        height: 150,
        child: Row(
          children: [
            ColoredBox(
              color: colorTheme?.extraColor ?? Colors.black,
              child: const SizedBox(
                width: 12,
                height: double.infinity,
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    Expanded(
                      flex: 6,
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  todo.title,
                                  style: TextStyle(
                                    color: colorTheme?.extraTextColor,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  todo.description ?? '',
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: colorTheme?.extraTextColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 24),
                          IconButton(
                            onPressed: () {
                              ref.read(todosProvider.notifier).toggle(todo.id);
                            },
                            icon: Icon(
                              Icons.check_circle_outline,
                              color: (todo.state == 'completed')
                                  ? colorTheme?.primaryColor
                                  : Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Divider(
                      thickness: 0.5,
                      color: colorTheme?.extraTextColor.withOpacity(0.5),
                    ),
                    Expanded(
                      flex: 4,
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              'Today   11:25 PM',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 16,
                                color: colorTheme?.extraTextColor,
                              ),
                            ),
                          ),
                          const SizedBox(width: 24),
                          IconButton(
                            onPressed: () => ref
                                .read(todosProvider.notifier)
                                .removeTodo(todo.id),
                            icon: Icon(
                              Icons.delete,
                              color: colorTheme?.secoderyAccent,
                            ),
                          ),
                        ],
                      ),
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

class AstronautPlaceholder extends StatelessWidget {
  const AstronautPlaceholder({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: 20,
      child: Padding(
        padding: const EdgeInsets.all(24.0),
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

class TODOScreenAppBar extends StatelessWidget {
  const TODOScreenAppBar({
    super.key,
    required this.colorTheme,
  });

  final ColorsTheme? colorTheme;

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(
        maxWidth: 980,
      ),
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Row(
          children: [
            DecoratedBox(
              decoration: BoxDecoration(
                color: colorTheme?.white,
                shape: BoxShape.circle,
              ),
              child: Padding(
                padding: const EdgeInsets.all(3.0),
                child: CircleAvatar(
                  maxRadius: 32,
                  foregroundImage: const AssetImage(
                    'assets/images/avatar.jpg',
                  ),
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
                      color: colorTheme?.extraTextColor,
                    ),
                  ),
                  Text(
                    'Mr Candyman.',
                    style: context.theme.textTheme.titleLarge,
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  'Thu, 12 March 2022',
                  style: context.theme.textTheme.titleMedium,
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CountWidget(
                      color: colorTheme?.primaryAccent ?? Colors.green,
                      amount: 0,
                    ),
                    CountWidget(
                      color: colorTheme?.mainAccent ?? Colors.yellow,
                      amount: 0,
                    ),
                    CountWidget(
                      color: colorTheme?.secoderyAccent ?? Colors.purple,
                      amount: 0,
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class CountWidget extends StatelessWidget {
  const CountWidget({
    super.key,
    required this.amount,
    required this.color,
  });

  final int amount;
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
            '$amount',
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

extension ThemeGetter on BuildContext {
  ThemeData get theme => Theme.of(this);
}
