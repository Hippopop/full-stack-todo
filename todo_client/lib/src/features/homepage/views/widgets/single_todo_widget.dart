import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_client/src/repository/todo_repository/models/models.dart';
import 'package:todo_client/src/features/homepage/controllers/homepage_controllers.dart';
import 'package:todo_client/src/system/themes/extensions/theme_extensions.dart';

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
                              ref
                                  .read(todosController.notifier)
                                  .toggle(todo.id);
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
                                .read(todosController.notifier)
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
