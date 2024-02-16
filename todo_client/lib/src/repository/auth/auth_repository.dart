import 'package:todo_client/src/repository/repository.dart';
export 'models/models.dart';

abstract class AuthRepository {
  final RequestHandler requestHandler;

  AuthRepository({
    required this.requestHandler,
  });

  Future<ResponseWrapper<Map, AuthResponse>> register({
    required AppUser user,
    required String password,
  });

  Future<ResponseWrapper<Map, AuthResponse>> login({
    required String email,
    required String password,
  });

  Future<ResponseWrapper<Map, UserToken>> refreshToken({
    required String refreshToken,
  });
}
