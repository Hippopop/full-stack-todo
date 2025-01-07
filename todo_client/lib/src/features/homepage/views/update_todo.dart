import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_client/src/features/homepage/controllers/homepage_controllers.dart';
import 'package:todo_client/src/features/homepage/views/widgets/custom_icon_button.dart';
import 'package:todo_client/src/repository/repository.dart';
import 'package:todo_client/src/utilities/extensions/string_extensions.dart';
import 'package:todo_client/src/utilities/scaffold_utils/snackbar_util.dart';

class UpdateTodoCard extends ConsumerStatefulWidget {
  const UpdateTodoCard({
    super.key,
    required this.selectedTodo,
  });
  final Todo selectedTodo;
  static const route = '/update_todo';

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AddTodoCardState();
}

class _AddTodoCardState extends ConsumerState<UpdateTodoCard> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _titleController;
  late final TextEditingController _descriptionController;

  @override
  void initState() {
    super.initState();
    _status = widget.selectedTodo.state;
    _priority = widget.selectedTodo.priority;
    _titleController = TextEditingController(text: widget.selectedTodo.title);
    _descriptionController =
        TextEditingController(text: widget.selectedTodo.description);
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
        id: widget.selectedTodo.id,
        state: _status,
        priority: _priority,
        title: _titleController.text,
        description: _descriptionController.text,
      );
      await ref.read(todosController.notifier).editTodo(todo).then((value) {
        if (context.mounted) {
          context.pop();
        }
      }).catchError((e, s) {
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
                              'Update Todo',
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
                    CustomIconButton(
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
