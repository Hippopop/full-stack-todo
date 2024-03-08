import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_client/src/data/todo_provider/todo_repository_impl.dart';
import 'package:todo_client/src/repository/repository.dart';


final todoProvider =
    Provider.family<TodoProvider, RequestHandler>((ref, reqHandler) {
  return TodoProvider(requestHandler: reqHandler);
});
