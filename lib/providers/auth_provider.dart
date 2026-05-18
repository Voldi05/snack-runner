import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../router/app_router.dart';

final authProvider = StateNotifierProvider<AuthNotifier, bool>(
  (ref) => AuthNotifier(),
);

class AuthNotifier extends StateNotifier<bool> {
  AuthNotifier() : super(false);

  void login() {
    state = true;
    AppRouter.notifyAuthChanged(true);
  }

  void logout() {
    state = false;
    AppRouter.notifyAuthChanged(false);
  }
}
