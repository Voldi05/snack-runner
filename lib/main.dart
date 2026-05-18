import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:snack_runner/providers/auth_provider.dart';
import 'package:snack_runner/providers/user_provider.dart';
import 'package:snack_runner/router/app_router.dart';
import 'package:snack_runner/services/auth_service.dart';
import 'package:snack_runner/theme/app_theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final token = await AuthService().getToken();
  final isLoggedIn = token != null;
  AppRouter.notifyAuthChanged(isLoggedIn);
  runApp(
    ProviderScope(
      child: SnackRunnerApp(initialAuth: isLoggedIn, initialUser: token ?? ''),
    ),
  );
}

class SnackRunnerApp extends ConsumerStatefulWidget {
  final bool initialAuth;
  final String initialUser;

  const SnackRunnerApp({
    super.key,
    required this.initialAuth,
    required this.initialUser,
  });

  @override
  ConsumerState<SnackRunnerApp> createState() => _SnackRunnerAppState();
}

class _SnackRunnerAppState extends ConsumerState<SnackRunnerApp> {
  late final AppRouter _router;

  @override
  void initState() {
    super.initState();
    _router = AppRouter(isLoggedIn: widget.initialAuth);
    if (widget.initialAuth) {
      ref.read(userProvider.notifier).state = widget.initialUser;
      ref.read(authProvider.notifier).login();
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'SnackRunner',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.theme,
      themeMode: ThemeMode.dark,
      routerConfig: _router.router,
    );
  }
}
