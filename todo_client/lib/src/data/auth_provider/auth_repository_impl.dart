import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart' show MediaType;
import 'package:todo_client/src/constants/server/api_config.dart';
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
  Future<ResponseWrapper<AuthResponse>> register({
    required String name,
    required String email,
    required String phone,
    required String password,
    required ({String imageName, List<int> imageData})? image,
  }) async {
    final Map<String, dynamic> registrationData = {
      'name': name,
      'email': email,
      'phone': phone,
      'password': password,
      if (image != null)
        'image': MultipartFile.fromBytes(
          image.imageData,
          filename: image.imageName,
          contentType: MediaType.parse("image/jpeg"),
        ),
    };

    final raw = await requestHandler.post(
      APIConfig.register,
      FormData.fromMap(registrationData),
    );

    return ResponseWrapper<AuthResponse>.fromMap(
      rawResponse: raw,
      purserFunction: (json) => AuthResponse.fromJson(json),
    );
  }
}
