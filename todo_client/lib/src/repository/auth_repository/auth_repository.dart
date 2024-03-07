import 'package:todo_client/src/repository/repository.dart';
export 'models/models.dart';

abstract class AuthRepository {
  final RequestHandler requestHandler;

  AuthRepository({
    required this.requestHandler,
  });

  Future<ResponseWrapper<AuthResponse>> register({
    required AppUser user,
    required String password,
  });

  Future<ResponseWrapper<AuthResponse>> login({
    required String email,
    required String password,
  });

  Future<ResponseWrapper<UserToken>> refreshToken({
    required String refreshToken,
  });
}
