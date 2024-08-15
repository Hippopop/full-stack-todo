import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_client/src/repository/repository.dart';
import 'package:todo_client/src/repository/server/source/config_provider.dart';
import 'package:todo_client/src/utilities/dribble_snackbar/scaffold_utilities.dart';
import 'package:todo_client/src/data/todo_provider/todo_repository_provider.dart';
import 'package:todo_client/src/data/todo_provider/todo_repository_impl.dart';

final todosController = AsyncNotifierProvider<TodosNotifier, List<Todo>>(() {
  return TodosNotifier();
});

class TodosNotifier extends AsyncNotifier<List<Todo>> {
  late RequestHandler _handler;
  late TodoProvider _provider;

  @override
  Future<List<Todo>> build() async {
    _handler = ref.watch(requestHandlerProvider);
    _provider = ref.watch(todoProvider(_handler));
    return await getAllTodos();
  }

  Future<List<Todo>> getAllTodos() async {
    try {
      final response = await _provider.getAllTodo();
      if (response.isSuccess) {
        return response.data!;
      } else {
        showToastError(response.msg);
        throw response.msg;
      }
    } catch (e, s) {
      log("#GET_ALL_TODO", error: e, stackTrace: s);
      if (e is RequestException) {
        e.handleError(defaultMessage: "Unexpected error occurred!");
      }
      rethrow;
    }
  }

  Future<void> addTodo(Todo todo) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final res = await _provider.addTodo(newTodo: todo);
      if (res.isSuccess) {
        showToastSuccess("TODO Successfully Added!");
      }
      return getAllTodos();
    });
  }

  Future<void> removeTodo(int todoId) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final res = await _provider.deleteSingleTodo(id: todoId);
      if (res.isSuccess) {
        showToastSuccess("TODO Successfully Removed!");
      }
      return getAllTodos();
    });
  }

  Future<void> toggle(int todoId) async {
    final currentState =
        state.asData?.value.where((item) => item.id == todoId).first;
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final res = await _provider.updateTodo(
        newTodo: currentState!.copyWith(
          state: currentState.state == TodoState.active
              ? TodoState.completed
              : TodoState.active,
        ),
      );
      if (res.isSuccess) {
        showToastSuccess("TODO Successfully Updated!");
      }
      return getAllTodos();
    });
  }
}
