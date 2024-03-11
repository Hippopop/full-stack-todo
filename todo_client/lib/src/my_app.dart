import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_client/src/constants/server/api/api_config.dart';
import 'package:todo_client/src/utilities/dribble_snackbar/scaffold_utilities.dart';

import 'system/routes/router.dart';
import 'system/themes/app_theme.dart';

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    log("Current BaseUrl : ${APIConfig.baseURl}");
    final goRouter = ref.watch(goRouterProvider);
    return MaterialApp.router(
      theme: lightTheme,
      routerConfig: goRouter,
      debugShowCheckedModeBanner: false,
      scaffoldMessengerKey: ScaffoldUtilities.instance.key,
    );
  }
}
