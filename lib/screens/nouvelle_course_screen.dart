import 'package:flutter/material.dart';

class NouvelleCourseScreen extends StatelessWidget {
  const NouvelleCourseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(child: Center(child: Text('Nouvelle course'))),
    );
  }
}
