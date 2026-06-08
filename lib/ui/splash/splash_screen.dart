import 'package:badargo_task/data/constants/app_assets.dart';
import 'package:badargo_task/ui/splash/splash_vm.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:stacked/stacked.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
      viewModelBuilder: () => SplashVm(),
      onViewModelReady: (vm) => vm.initTimer(),
      builder: (context, vm, _) => Scaffold(
        body: Container(
          width: 100.w,
          height: 100.h,
          alignment: Alignment.center,
          padding: EdgeInsets.symmetric(horizontal: 10.w),
          child: Image.asset(AppAssets.logo),
        ),
      ),
    );
  }
}
