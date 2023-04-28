import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_client/src/domain/model/todo/todo.dart';

class TodosNotifier extends Notifier<List<Todo>> {
  @override
  List<Todo> build() {
    return [
      const Todo(
        id: 1,
        title: 'Testing Riverpod TODO!',
        description: 'Random Testing description.',
        state: 'completed',
        priority: 'high',
      ),
      const Todo(
        id: 2,
        title: 'Testing Riverpod TODO2!',
        description: 'Random Testing description.',
        state: 'active',
        priority: 'high',
      ),
      const Todo(
        id: 3,
        title: 'Testing Riverpod TODO!',
        description: 'Random Testing description.',
        state: 'completed',
        priority: 'low',
      ),
      const Todo(
        id: 4,
        title: 'Testing Riverpod TODO4!',
        description: 'Random Testing description.',
        state: 'completed',
        priority: 'high',
      ),
      const Todo(
        id: 5,
        title: 'Testing Riverpod TODO5!',
        description: 'Random Testing description.',
        state: 'completed',
        priority: 'medium',
      ),
    ];
  }

  void addTodo(Todo todo) {
    state = [...state, todo];
  }

  void removeTodo(int todoId) {
    state = [
      for (final todo in state)
        if (todo.id != todoId) todo,
    ];
  }

  void toggle(int todoId) {
    state = [
      for (final todo in state)
        if (todo.id == todoId)
          todo.copyWith(
            state: todo.state == 'completed' ? 'active' : 'completed',
          )
        else
          todo,
    ];
  }
}

final todosProvider = NotifierProvider<TodosNotifier, List<Todo>>(() {
  return TodosNotifier();
});
