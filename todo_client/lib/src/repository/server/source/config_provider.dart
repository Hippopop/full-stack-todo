import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_client/src/constants/server/api_config.dart';
import 'package:todo_client/src/repository/server/source/helpers/token_handler.dart';

import 'helpers/request_handler_provider.dart';

int val = 0;

final requestHandlerProvider = Provider<RequestHandler>(
  (ref) {
    print(val++);
    final tokenInterceptor = ref.watch(tokenInterceptorProvider);
    return RequestHandler(
      baseURl: APIConfig.baseURl,
      interceptor: [tokenInterceptor],
    );
  },
);
