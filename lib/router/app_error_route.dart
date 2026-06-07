import 'package:flutter/material.dart';

class AppErrorRoute extends StatelessWidget {
  const AppErrorRoute({super.key});

// you should never see this screen, if you do, it means you have passed wrong route name
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text(
          'You should not be here, check route name',
        ),
      ),
    );
  }
}
