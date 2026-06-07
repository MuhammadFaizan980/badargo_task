import 'package:badargo_task/ui/splash/splash_vm.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
      viewModelBuilder: () => SplashVm(),
      onViewModelReady: (vm) => vm.initTimer(),
      builder: (context, vm, _) => Scaffold(body: Center(child: Text('Welcome to Badargo...'))),
    );
  }
}
