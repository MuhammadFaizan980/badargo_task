import 'package:badargo_task/ui/driver_home/driver_home_vm.dart';
import 'package:badargo_task/utils/app_text_styles.dart';
import 'package:badargo_task/utils/extensions/double_extension.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:stacked/stacked.dart';

class HomeHeader extends ViewModelWidget<DriverHomeVm> {
  const HomeHeader({super.key});

  @override
  Widget build(BuildContext context, DriverHomeVm vm) {
    return Visibility(
      visible: vm.hasActiveOrder,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
        width: 100.w,
        color: Colors.white,
        alignment: Alignment.center,
        child: Column(
          children: [
            Text('Order in progress...', style: AppTextStyles.s16wBold()),
            if (vm.accuracy != null) ...[
              SizedBox(height: 1.h),
              Text('${vm.accuracy!.toAccuracyDescription()} Accuracy', style: AppTextStyles.s16wNormal()),
            ],
          ],
        ),
      ),
    );
  }
}
