import 'package:flutter/material.dart';
import 'package:snack_runner/screens/login_screen.dart';
import 'package:snack_runner/theme/app_theme.dart';

void main() {
  runApp(const SnackRunnerApp());
}

class SnackRunnerApp extends StatelessWidget {
  const SnackRunnerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SnackRunner',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.theme,
      themeMode: ThemeMode.dark,
      home: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 412),
          child: const LoginScreen(),
        ),
      ),
    );
  }
}
