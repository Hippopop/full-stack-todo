import 'package:todo_client/src/constants/server/api/api_config.dart';
import 'package:todo_client/src/repository/repository.dart';

class AuthProvider extends AuthRepository {
  AuthProvider({required super.requestHandler});

  @override
  Future<ResponseWrapper<Map, AuthResponse>> login(
      {required String email, required String password}) async {
    final raw = await requestHandler.post(
      APIConfig.addTodo,
      {"email": email, "password": password},
    );
    final data =
        ResponseWrapper<Map<String, dynamic>, AuthResponse>.fromMap(raw.data);
    await data.purseResponse((rawData) => AuthResponse.fromJson(rawData!));
    return data;
  }

  @override
  Future<ResponseWrapper<Map, UserToken>> refreshToken(
      {required String refreshToken}) async {
    final raw = await requestHandler
        .post(APIConfig.addTodo, {"refreshToken": refreshToken});
    final data =
        ResponseWrapper<Map<String, dynamic>, UserToken>.fromMap(raw.data);
    await data.purseResponse((rawData) => UserToken.fromJson(rawData!));
    return data;
  }

  @override
  Future<ResponseWrapper<Map, AuthResponse>> register(
      {required AppUser user, required String password}) async {
    final raw = await requestHandler.post(
      APIConfig.addTodo,
      {...user.toJson(), "password": password},
    );
    final data =
        ResponseWrapper<Map<String, dynamic>, AuthResponse>.fromMap(raw.data);
    await data.purseResponse((rawData) => AuthResponse.fromJson(rawData!));
    return data;
  }
}
