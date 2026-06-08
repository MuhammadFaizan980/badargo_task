import 'package:badargo_task/ui/driver_home/driver_home_vm.dart';
import 'package:badargo_task/utils/widgets/app_button.dart';
import 'package:badargo_task/utils/widgets/home_header.dart';
import 'package:badargo_task/utils/widgets/map_box_widget.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:sizer/sizer.dart';
import 'package:stacked/stacked.dart';

class DriverHomeScreen extends StatelessWidget {
  const DriverHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
      viewModelBuilder: () => DriverHomeVm(
        appBaseModel: GetIt.I.get(),
        homeRepo: GetIt.I.get(),
        appPermissionHandler: GetIt.I.get(),
        locationUtils: GetIt.I.get(),
        isMock: false,
      ),
      onViewModelReady: (vm) async => vm.hasActiveOrder = await vm.getOrderStatus(),
      builder: (context, vm, _) => Scaffold(
        body: Column(
          children: [
            const HomeHeader(),
            Expanded(
              child: MapBoxWidget(
                initialLat: 37.43296265331129,
                initialLng: -122.08832357078792,
                userLat: null,
                userLng: null,
                scrollable: true,
                onLocationServiceStopped: vm.onLocationServiceStopped,
                onLocationUpdated: vm.onLocationUpdated,
              ),
            ),
            if (!vm.hasActiveOrder) ...[
              AppButton.expanded(label: 'Start Order', fontWeight: FontWeight.bold, onTap: vm.onAcceptOrderTapped),
              SizedBox(height: 1.h),
            ],
            if (vm.hasActiveOrder) ...[
              AppButton.expanded(
                label: 'End Order',
                fontWeight: FontWeight.bold,
                bgColor: Colors.red,
                onTap: vm.cancelOrder,
              ),
            ],

            const SafeArea(child: SizedBox()),
          ],
        ),
      ),
    );
  }
}
