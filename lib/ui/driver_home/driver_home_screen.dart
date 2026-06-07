import 'package:badargo_task/ui/driver_home/driver_home_vm.dart';
import 'package:badargo_task/utils/app_text_styles.dart';
import 'package:badargo_task/utils/widgets/app_button.dart';
import 'package:badargo_task/utils/widgets/map_box_widget.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:stacked/stacked.dart';

class DriverHomeScreen extends StatelessWidget {
  const DriverHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
      viewModelBuilder: () => DriverHomeVm(),
      builder: (context, vm, _) => Scaffold(
        body: Column(
          children: [
            FutureBuilder(
              future: vm.appBaseModel.getOrderStatus(),
              builder: (context, snapshot) => Visibility(
                visible: snapshot.hasData && snapshot.data!,
                child: Container(
                  padding: EdgeInsets.only(top: 1.h),
                  width: 100.w,
                  height: 10.h,
                  color: Colors.white,
                  alignment: Alignment.center,
                  child: Text('Order in progress...', style: AppTextStyles.s18wBold()),
                ),
              ),
            ),
            Expanded(
              child: MapBoxWidget(
                initialLat: 37.43296265331129,
                initialLng: -122.08832357078792,
                userLat: null,
                userLng: null,
                markers: {},
                scrollable: true,
                onMapTapped: (coordinates) {},
              ),
            ),
            AppButton.expanded(label: 'Accept Order', onTap: vm.onAcceptOrderTapped),
            SizedBox(height: 1.h),
            AppButton.expanded(
              label: 'Reject Order',
              onTap: () {
                vm.appBaseModel.cancelOrder();
                vm.notifyListeners();
              },
            ),
            const SafeArea(child: SizedBox()),
          ],
        ),
      ),
    );
  }
}
