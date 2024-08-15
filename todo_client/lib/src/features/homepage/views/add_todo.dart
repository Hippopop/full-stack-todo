import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_client/src/features/homepage/controllers/homepage_controllers.dart';
import 'package:todo_client/src/repository/repository.dart';
import 'package:todo_client/src/utilities/extensions/string_extensions.dart';
import 'package:todo_client/src/utilities/dribble_snackbar/scaffold_utilities.dart';

class AddTodoCard extends ConsumerStatefulWidget {
  const AddTodoCard({super.key});
  static const route = '/add_todo';

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AddTodoCardState();
}

class _AddTodoCardState extends ConsumerState<AddTodoCard> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _titleController;
  late final TextEditingController _descriptionController;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController();
    _descriptionController = TextEditingController();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  TodoState _status = TodoState.active;
  Priority _priority = Priority.low;
  Color get _bgColor => switch (_priority) {
        Priority.high => Colors.purple,
        Priority.medium => Colors.pink,
        Priority.low => Colors.pink.shade100,
      };

  _submitTodoForm() async {
    if (_formKey.currentState?.validate() ?? false) {
      final todo = Todo(
        id: 0,
        state: _status,
        priority: _priority,
        title: _titleController.text,
        description: _descriptionController.text,
      );
      await ref
          .read(todosController.notifier)
          .addTodo(todo)
          .then((value) => context.pop())
          .catchError((e, s) {
        showToastError(e.toString());
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: 600,
        width: 400,
        child: Material(
          clipBehavior: Clip.hardEdge,
          borderRadius: const BorderRadius.all(Radius.circular(12)),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 400),
            color: _bgColor.withOpacity(0.3),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 16),
                            const Text(
                              'Create a new Todo',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 32),
                            TextFormField(
                              controller: _titleController,
                              validator: (value) => ((value?.length ?? 0) > 2)
                                  ? null
                                  : "Title is too short!",
                              decoration: const InputDecoration(
                                label: Text(
                                  "Title",
                                ),
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.grey,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 12),
                            Text(
                              "Priority",
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.grey.shade700,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                for (Priority value in Priority.values)
                                  Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Radio<Priority>(
                                        value: value,
                                        groupValue: _priority,
                                        onChanged: (value) {
                                          setState(
                                            () {
                                              _priority = value!;
                                            },
                                          );
                                        },
                                      ),
                                      const SizedBox(width: 8),
                                      Text(
                                        value.name.capFirst,
                                      ),
                                    ],
                                  ),
                              ],
                            ),
                            const SizedBox(height: 12),
                            Text(
                              "Activity",
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.grey.shade700,
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                for (TodoState value in TodoState.values)
                                  Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Radio<TodoState>(
                                        value: value,
                                        groupValue: _status,
                                        onChanged: (value) {
                                          setState(
                                            () {
                                              _status = value!;
                                            },
                                          );
                                        },
                                      ),
                                      const SizedBox(width: 8),
                                      Text(
                                        value.name.capFirst,
                                      ),
                                    ],
                                  ),
                              ],
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 12.0),
                                    child: Text(
                                      "Description",
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.grey.shade700,
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: TextFormField(
                                      maxLines: 10,
                                      controller: _descriptionController,
                                      decoration: const InputDecoration(
                                        border: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Colors.grey,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 12),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    CustomIconedButton(
                      height: 48,
                      text: "Create",
                      icon: const Icon(Icons.add),
                      onPressed: _submitTodoForm,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class CustomIconedButton extends StatefulWidget {
  const CustomIconedButton({
    super.key,
    this.height,
    this.width,
    this.style,
    this.textStyle,
    this.onPressed,
    required this.icon,
    required this.text,
  });

  final String text;
  final Widget icon;

  final double? height;
  final double? width;
  final TextStyle? textStyle;
  final ButtonStyle? style;
  final VoidCallback? onPressed;

  @override
  State<CustomIconedButton> createState() => _CustomIconedButtonState();
}

class _CustomIconedButtonState extends State<CustomIconedButton> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.height ?? double.infinity,
      width: widget.width ?? double.infinity,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: ElevatedButton.icon(
              onPressed: widget.onPressed,
              icon: widget.icon,
              label: Text(
                widget.text,
                style: widget.textStyle,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
