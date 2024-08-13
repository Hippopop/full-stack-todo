import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fresh_dio/fresh_dio.dart';
import 'package:todo_client/src/repository/repository.dart';
import 'package:todo_client/src/repository/storage/auth_repository/authentication_storage.dart';
import 'package:todo_client/src/utilities/dribble_snackbar/scaffold_utilities.dart';

import 'models/auth_state/app_authentication.dart';

final authStateNotifierProvider =
    NotifierProvider<AuthenticationStateNotifier, AuthenticationState>(
  AuthenticationStateNotifier.new,
);

class AuthenticationStateNotifier extends Notifier<AuthenticationState>
    implements TokenStorage<OAuth2Token> {
  late final AuthenticationStorage _storage = const AuthenticationStorage();

  @override
  build() {
    final tokens = _storage.getUserToken();
    final user = _storage.getCurrentUser();
    return AuthenticationState(token: tokens, currentUser: user);
  }

  logout() async {
    await _storage.delete();
    ref.invalidateSelf();
  }

  Future<void> saveAppUser(AppUser newUser) async {
    await _storage.saveAppUser(newUser);
    ref.invalidateSelf();
    showToastSuccess("User logged out successfully!");
  }

  Future<void> saveUserToken(UserToken userToken) async =>
      await write(userToken.toOAuth2Token);

  @override
  Future<void> delete() async {
    await _storage.clearTokens();
    ref.invalidateSelf();
  }

  @override
  Future<OAuth2Token?> read() async {
    final tokenSet = _storage.getUserToken();
    if (tokenSet == null) return null;
    return OAuth2Token(
        accessToken: tokenSet.accessToken, refreshToken: tokenSet.refreshToken);
  }

  @override
  Future<void> write(OAuth2Token token) async {
    await _storage.saveUserToken(token.accessToken, token.refreshToken!);
    ref.invalidateSelf();
  }
}
