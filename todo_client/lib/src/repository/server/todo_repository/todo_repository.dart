import 'package:todo_client/src/repository/repository.dart';
export 'models/models.dart';

abstract class TodoRepository {
  TodoRepository({
    required this.requestHandler,
  });

  final RequestHandler requestHandler;

  Future<ResponseWrapper<List<Todo>>> getAllTodo();
  Future<ResponseWrapper<Todo>> addTodo({required Todo newTodo});
  Future<ResponseWrapper<Todo>> updateTodo({required Todo newTodo});
  Future<ResponseWrapper<int>> deleteSingleTodo({required int id});
  Future<ResponseWrapper<List<int>>> deleteMultipleTodo({
    required List<int> idList,
  });
}
