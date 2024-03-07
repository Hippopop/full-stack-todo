import 'package:todo_client/src/constants/server/api/api_config.dart';
import 'package:todo_client/src/repository/repository.dart';

class AuthProvider extends AuthRepository {
  AuthProvider({required super.requestHandler});

  @override
  Future<ResponseWrapper<AuthResponse>> login(
      {required String email, required String password}) async {
    final raw = await requestHandler.post(
      APIConfig.login,
      {"email": email, "password": password},
    );

    return ResponseWrapper<AuthResponse>.fromMap(
      rawResponse: raw,
      purserFunction: (rawData) => AuthResponse.fromJson(rawData),
    );
  }

  @override
  Future<ResponseWrapper<UserToken>> refreshToken(
      {required String refreshToken}) async {
    final raw = await requestHandler
        .post(APIConfig.refresh, {"refreshToken": refreshToken});
    return ResponseWrapper<UserToken>.fromMap(
      rawResponse: raw,
      purserFunction: (rawData) => UserToken.fromJson(rawData),
    );
  }

  @override
  Future<ResponseWrapper<AuthResponse>> register(
      {required AppUser user, required String password}) async {
    final raw = await requestHandler.post(
      APIConfig.register,
      {...user.toJson(), "password": password},
    );
    return ResponseWrapper<AuthResponse>.fromMap(
      rawResponse: raw,
      purserFunction: (json) => AuthResponse.fromJson(json),
    );
  }
}
