import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fresh_dio/fresh_dio.dart';
import 'package:hive/hive.dart';
import 'package:todo_client/src/repository/repository.dart';
import 'package:todo_client/src/repository/storage/source/hive_config.dart';

final tokenStorageProvider = Provider<HiveTokenStorage>(
  (ref) => HiveTokenStorage(),
);

class HiveTokenStorage extends TokenStorage<OAuth2Token> {
  late final hiveConfig = HiveConfig();

  Box<String> get myBox => hiveConfig.tokenBox;
  static const accessTokenKey = "#ACCESS_TOKEN";
  static const refreshTokenKey = "#REFRESH_TOKEN";

  Future<void> saveUserToken(UserToken userToken) async =>
      await write(userToken.toOAuth2Token);

  @override
  Future<void> delete() async => await myBox.clear();

  @override
  Future<OAuth2Token?> read() async {
    final access = myBox.get(accessTokenKey);
    final refresh = myBox.get(refreshTokenKey);
    if (access == null || refresh == null) return null;
    return OAuth2Token(accessToken: access, refreshToken: refresh);
  }

  @override
  Future<void> write(OAuth2Token token) async {
    await myBox.put(accessTokenKey, token.accessToken);
    await myBox.put(refreshTokenKey, token.refreshToken!);
  }
}
