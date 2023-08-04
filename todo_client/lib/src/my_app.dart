import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_client/src/utilities/scaffold_utilities.dart';

import 'system/routes/router.dart';
import 'system/themes/extensions/theme_extensions.dart';

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final goRouter = ref.watch(goRouterProvider);
    return MaterialApp.router(
      routerConfig: goRouter,
      debugShowCheckedModeBanner: false,
      scaffoldMessengerKey: ScaffoldUtilities.instance.key,
      theme: ThemeData(
        extensions: {
          ColorsTheme(
            white: Colors.white,
            black: Colors.black,
            extraColor: const Color(0xffF8B6C0),
            mainAccent: const Color(0xffF2B872),
            primaryColor: const Color(0xff3084F2),
            primaryAccent: const Color(0xff96D9A0),
            extraTextColor: const Color(0xff3B3C40),
            secoderyAccent: const Color(0xffA0ACF2),
            backgroundColor: const Color(0xffF2F2F2),
          ),
        },
      ),
    );
  }
}
