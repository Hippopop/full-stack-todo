import 'package:hive_flutter/hive_flutter.dart';

/// NOTE: It is always better to not have [Global Models] for both Local and
/// Server repositories. Instead use custom Hive data models (a.k.a [TypeAdapter]).
/// Also not open all the [HiveBoxes] on app start up, but open them strategically
/// based on the usage.
/// Doing everything right, you also move some of the [String] based [mixin] part to inside
/// the custom models. Which will be much efficient and performative for your app.
///
/// * But for this small and simple application. This should totally be fine!
class HiveConfig {
  static const tokenBoxKey = 'AUTH_TOKEN_STORAGE';

  static Future<void> initialize() async {
    await Hive.initFlutter();

    await Hive.openBox<String>(tokenBoxKey);
  }

  Box<String> get tokenBox => Hive.box(tokenBoxKey);

  Future<void> dispose() async {}
}
