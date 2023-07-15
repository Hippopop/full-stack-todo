import 'package:todo_client/src/repository/source/request_handler_provider.dart';
import 'package:todo_client/src/repository/source/response_wrapper.dart';

import 'models/models.dart';
export 'models/models.dart';

abstract class TodoRepository {
  TodoRepository({
    required this.requestHandler,
  });

  final RequestHandler requestHandler;

  Future<ResponseWrapper<List, List<Todo>>> getAllTodo();
  Future<ResponseWrapper<Map, Todo>> addTodo({required Todo newTodo});
  Future<ResponseWrapper<Map, Todo>> updateTodo({required Todo newTodo});
  Future<ResponseWrapper<int, int>> deleteSingleTodo({required int id});
  Future<ResponseWrapper<List<int>, List<int>>> deleteMultipleTodo({
    required List<int> idList,
  });
}
