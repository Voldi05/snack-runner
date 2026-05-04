import 'package:flutter/material.dart';
import 'package:snack_runner/screens/login_screen.dart';

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
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF1A6B4A)),
        fontFamily: 'Inter',
        useMaterial3: true,
      ),
      home: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 412),
          child: const LoginScreen(),
        ),
      ),
    );
  }
}
