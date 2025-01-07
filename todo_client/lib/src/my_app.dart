import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_client/src/constants/server/api_config.dart';
import 'package:todo_client/src/utilities/scaffold_utils/snackbar_util.dart';

import 'services/routes/router.dart';
import 'services/themes/app_theme.dart';

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    print("BASEURL -> ${APIConfig.baseURl}");
    final goRouter = ref.watch(goRouterProvider);
    return MaterialApp.router(
      theme: lightTheme,
      routerConfig: goRouter,
      debugShowCheckedModeBanner: false,
      scaffoldMessengerKey: SnackbarUtil.instance.key,
    );
  }
}
