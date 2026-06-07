import 'package:badargo_task/ui/driver_home/driver_home_vm.dart';
import 'package:badargo_task/utils/app_text_styles.dart';
import 'package:badargo_task/utils/extensions/double_extension.dart';
import 'package:badargo_task/utils/utils.dart';
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
                  padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
                  width: 100.w,
                  color: Colors.white,
                  alignment: Alignment.center,
                  child: SafeArea(
                    child: Column(
                      children: [
                        Text('Order in progress...', style: AppTextStyles.s18wBold()),
                        if (vm.appBaseModel.accuracy != null) ...[
                          SizedBox(height: 1.h),
                          Text(
                            '${vm.appBaseModel.accuracy!.toAccuracyDescription()} Accuracy',
                            style: AppTextStyles.s16wNormal(),
                          ),
                        ],
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: FutureBuilder(
                future: getCarMarker(
                  lat: vm.appBaseModel.lat ?? 37.43296265331129,
                  lng: vm.appBaseModel.lng ?? -122.08832357078792,
                  heading: vm.appBaseModel.heading ?? 0,
                ),
                builder: (context, snapshot) {
                  return MapBoxWidget(
                    controller: vm.appBaseModel.mapController,
                    initialLat: 37.43296265331129,
                    initialLng: -122.08832357078792,
                    userLat: null,
                    userLng: null,
                    markers: snapshot.hasData ? {snapshot.data!} : {},
                    scrollable: true,
                    onMapTapped: (coordinates) {},
                  );
                },
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
