import 'package:todo_client/src/constants/server/api/api_config.dart';
import 'package:todo_client/src/repository/repository.dart';

class TodoProvider extends TodoRepository {
  TodoProvider({required super.requestHandler});

  @override
  Future<ResponseWrapper<Todo>> addTodo({required Todo newTodo}) async {
    final raw = await requestHandler.post(
      APIConfig.addTodo,
      newTodo.toJson(),
    );
    return ResponseWrapper<Todo>.fromMap(
      rawResponse: raw,
      purserFunction: (json) => Todo.fromJson(json),
    );
  }

  @override
  Future<ResponseWrapper<List<int>>> deleteMultipleTodo({
    required List<int> idList,
  }) {
    // TODO: implement deleteMultipleTodo!
    throw UnimplementedError();
  }

  @override
  Future<ResponseWrapper<int>> deleteSingleTodo({required int id}) async {
    final raw = await requestHandler.delete(
      APIConfig.deleteTodo,
      {"delete": id},
    );
    return ResponseWrapper<int>.fromMap(
      rawResponse: raw,
      purserFunction: (json) => (json['deleted'] ?? -1),
    );
  }

  @override
  Future<ResponseWrapper<List<Todo>>> getAllTodo() async {
    final raw = await requestHandler.get(APIConfig.allTodo);
    return ResponseWrapper<List<Todo>>.fromMap(
      rawResponse: raw,
      purserFunction: (json) =>
          (json as List).map((e) => Todo.fromJson(e)).toList(),
    );
  }

  @override
  Future<ResponseWrapper<Todo>> updateTodo({required Todo newTodo}) async {
    final raw = await requestHandler.put(
      APIConfig.updateTodo,
      newTodo.toJson(),
    );
    return ResponseWrapper<Todo>.fromMap(
      rawResponse: raw,
      purserFunction: (json) => Todo.fromJson(json),
    );
  }
}
