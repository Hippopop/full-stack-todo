import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_client/src/repository/repository.dart';
import 'package:todo_client/src/data/auth_provider/auth_repository_impl.dart';

final authProvider =
    Provider.family<AuthProvider, RequestHandler>((ref, reqHandler) {
  return AuthProvider(requestHandler: reqHandler);
});
