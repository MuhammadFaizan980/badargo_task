import 'package:badargo_task/utils/app_text_styles.dart';
import 'package:badargo_task/utils/widgets/app_button.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class PermissionsMessageDialog extends StatelessWidget {
  final String title;
  final String message;
  final IconData iconData;
  final Color? iconColor;
  final Function()? onOpenSettingsTapped;
  final Function()? onCancelTapped;

  const PermissionsMessageDialog({
    super.key,
    required this.title,
    required this.message,
    required this.iconData,
    this.iconColor,
    required this.onOpenSettingsTapped,
    required this.onCancelTapped,
  });

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: AlertDialog(
        surfaceTintColor: Colors.white,
        backgroundColor: Colors.white,
        contentPadding: EdgeInsets.zero,
        content: SizedBox(
          width: 100.w,
          child: SingleChildScrollView(
            padding: EdgeInsets.all(8.w),
            child: Column(
              children: [
                Icon(iconData, size: 7.h, color: iconColor),
                SizedBox(height: 1.h),
                Text(title, textAlign: TextAlign.center, style: AppTextStyles.s18wBold()),
                SizedBox(height: 0.5.h),
                Text(message, textAlign: TextAlign.center, style: AppTextStyles.s16wNormal()),
                SizedBox(height: 2.h),
                AppButton.expanded(label: 'Open Settings', onTap: onOpenSettingsTapped),
                SizedBox(height: 2.h),
                GestureDetector(
                  onTap: onCancelTapped,
                  child: Text('Cancel', style: TextStyle(color: Colors.black.withOpacity(0.35))),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
