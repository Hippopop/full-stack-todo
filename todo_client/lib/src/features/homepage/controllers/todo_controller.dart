import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_client/src/data/todo_provider/todo_provider.dart';
import 'package:todo_client/src/data/todo_provider/todo_repository_impl.dart';
import 'package:todo_client/src/repository/repository.dart';

/* class TodosNotifier extends Notifier<List<Todo>> {
  
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
}); */

class TodosNotifier extends AsyncNotifier<List<Todo>> {
  Future<List<Todo>> getAllTodos() async {
    try {
      final RequestHandler handler = ref.watch(requestHandlerProvider);
      final TodoProvider provider = ref.watch(todoProvider(handler));
      final response = await provider.getAllTodo();
      return response.data ?? [];
    } catch (e, s) {
      log("#GET_ALL_TODO", error: e, stackTrace: s);
      if (e is RequestException) {
        e.handleError(defaultMessage: "Unexpected error occured!");
      }
      return [];
    }
  }

  @override
  Future<List<Todo>> build() async {
    return await getAllTodos();
    /* return [
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
    ]; */
  }

  void addTodo(Todo todo) {
    // state = [...state, todo];
  }

  void removeTodo(int todoId) {
    /* state = [
      for (final todo in state)
        if (todo.id != todoId) todo,
    ]; */
  }

  void toggle(int todoId) {
    /* state = [
      for (final todo in state)
        if (todo.id == todoId)
          todo.copyWith(
            state: todo.state == 'completed' ? 'active' : 'completed',
          )
        else
          todo,
    ]; */
  }
}

final todosController = AsyncNotifierProvider<TodosNotifier, List<Todo>>(() {
  return TodosNotifier();
});
