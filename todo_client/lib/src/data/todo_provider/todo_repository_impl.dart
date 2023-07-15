import 'package:todo_client/src/constants/server/server_env_config.dart';
import 'package:todo_client/src/repository/repository.dart';

class TodoProvider extends TodoRepository {
  TodoProvider({required super.requestHandler});

  @override
  Future<ResponseWrapper<Map, Todo>> addTodo({required Todo newTodo}) async {
    final raw = await requestHandler.get(APIConfig.addTodo);
    final data = ResponseWrapper<Map<String, dynamic>, Todo>.fromMap(raw.data);
    data.purseResponse((rawData) => Todo.fromJson(rawData!));
    return data;
  }

  @override
  Future<ResponseWrapper<List<int>, List<int>>> deleteMultipleTodo({
    required List<int> idList,
  }) {
    // TODO: implement deleteMultipleTodo
    throw UnimplementedError();
  }

  @override
  Future<ResponseWrapper<int, int>> deleteSingleTodo({required int id}) {
    // TODO: implement deleteSingleTodo
    throw UnimplementedError();
  }

  @override
  Future<ResponseWrapper<List, List<Todo>>> getAllTodo() async {
    final raw = await requestHandler.get(APIConfig.allTodo);
    final data = ResponseWrapper<List, List<Todo>>.fromMap(raw.data);
    await data.purseResponse<List<Todo>>(
      (rawData) => rawData!.map((e) => Todo.fromJson(e)).toList(),
    );
    return data;
  }

  @override
  Future<ResponseWrapper<Map, Todo>> updateTodo({required Todo newTodo}) {
    // TODO: implement updateTodo
    throw UnimplementedError();
  }
}
