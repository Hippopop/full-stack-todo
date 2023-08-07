import 'package:todo_client/src/constants/server/api/api_config.dart';
import 'package:todo_client/src/repository/repository.dart';

class TodoProvider extends TodoRepository {
  TodoProvider({required super.requestHandler});

  @override
  Future<ResponseWrapper<Map, Todo>> addTodo({required Todo newTodo}) async {
    final raw = await requestHandler.post(
      APIConfig.addTodo,
      newTodo.toJson(),
    );
    final data = ResponseWrapper<Map<String, dynamic>, Todo>.fromMap(raw.data);
    await data.purseResponse((rawData) => Todo.fromJson(rawData!));
    return data;
  }

  @override
  Future<ResponseWrapper<Map<String, List<int>>, List<int>>>
      deleteMultipleTodo({
    required List<int> idList,
  }) {
    // TODO: implement deleteMultipleTodo!
    throw UnimplementedError();
  }

  @override
  Future<ResponseWrapper<Map<String, dynamic>, int>> deleteSingleTodo(
      {required int id}) async {
    final raw = await requestHandler.delete(
      APIConfig.deleteTodo,
      {"delete": id},
    );
    final data = ResponseWrapper<Map<String, dynamic>, int>.fromMap(raw.data);
    await data.purseResponse<int>((rawData) => rawData?['deleted'] ?? -1);
    return data;
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
  Future<ResponseWrapper<Map, Todo>> updateTodo({required Todo newTodo}) async {
    final raw = await requestHandler.put(
      APIConfig.updateTodo,
      newTodo.toJson(),
    );
    final data = ResponseWrapper<Map, Todo>.fromMap(raw.data);
    await data.purseResponse<Todo>(
      (rawData) => Todo.fromJson(rawData as Map<String, dynamic>),
    );
    return data;
  }
}
