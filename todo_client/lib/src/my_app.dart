import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_client/src/utilities/scaffold_utilities.dart';

import 'system/routes/router.dart';
import 'system/themes/app_theme.dart';

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final goRouter = ref.watch(goRouterProvider);
    return MaterialApp.router(
      routerConfig: goRouter,
      debugShowCheckedModeBanner: false,
      scaffoldMessengerKey: ScaffoldUtilities.instance.key,
      theme: lightTheme,
    );
  }
}
