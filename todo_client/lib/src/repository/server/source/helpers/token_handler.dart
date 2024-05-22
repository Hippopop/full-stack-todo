import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fresh_dio/fresh_dio.dart';
import 'package:todo_client/src/constants/server/api_config.dart';
import 'package:todo_client/src/repository/repository.dart';
import 'package:todo_client/src/repository/server/source/config_provider.dart';
import 'package:todo_client/src/repository/storage/auth_repository/token_storage.dart';

final tokenInterceptorProvider =
    NotifierProvider<TokenInterceptorNotifier, Interceptor>(
  TokenInterceptorNotifier.new,
);

class TokenInterceptorNotifier extends Notifier<Interceptor> {
  @override
  Interceptor build() {
    final storage = ref.watch(tokenStorageProvider);
    return Fresh.oAuth2(
      tokenStorage: storage,
      shouldRefresh: (response) => response?.statusCode == 400,
      refreshToken: (token, httpClient) async {
        final res = await httpClient.post(APIConfig.refresh, data: {
          'token': token?.accessToken,
          'refreshToken': token?.refreshToken,
        });
        final wrapper = ResponseWrapper<UserToken>.fromMap(
          rawResponse: res,
          purserFunction: (json) => UserToken.fromJson(json),
        );
        return wrapper.data!.toOAuth2Token;
      },
    );
  }

  Future<void> saveNewUserToken(UserToken token) async {
    final storage = ref.read(tokenStorageProvider);
    await storage.saveUserToken(token);
    ref.invalidate(requestHandlerProvider);
  }
}
