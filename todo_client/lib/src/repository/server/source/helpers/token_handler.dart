import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fresh_dio/fresh_dio.dart';
import 'package:todo_client/src/constants/server/api_config.dart';
import 'package:todo_client/src/repository/repository.dart';
import 'package:todo_client/src/system/auth/auth_controller.dart';

final tokenInterceptorProvider =
    NotifierProvider<TokenInterceptorNotifier, Interceptor>(
  TokenInterceptorNotifier.new,
);

class TokenInterceptorNotifier extends Notifier<Interceptor> {
  @override
  Interceptor build() {
    ref.watch(authStateNotifierProvider);
    final storage = ref.watch(authStateNotifierProvider.notifier);
    return Fresh.oAuth2(
      tokenStorage: storage,
      shouldRefresh: (response) => response?.statusCode == 401,
      httpClient: Dio(
        BaseOptions(
          baseUrl: APIConfig.baseURl,
          receiveDataWhenStatusError: true,
          validateStatus: (status) => true,
        ),
      ),
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
}
