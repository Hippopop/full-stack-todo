import 'package:todo_client/src/repository/repository.dart';
export 'models/models.dart';

abstract class TodoRepository {
  TodoRepository({
    required this.requestHandler,
  });

  final RequestHandler requestHandler;

  Future<ResponseWrapper<List, List<Todo>>> getAllTodo();
  Future<ResponseWrapper<Map, Todo>> addTodo({required Todo newTodo});
  Future<ResponseWrapper<Map, Todo>> updateTodo({required Todo newTodo});
  Future<ResponseWrapper<Map<String, dynamic>, int>> deleteSingleTodo(
      {required int id});
  Future<ResponseWrapper<Map<String, List<dynamic>>, List<int>>>
      deleteMultipleTodo({
    required List<int> idList,
  });
}
