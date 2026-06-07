import 'package:badargo_task/main.dart';
import 'package:badargo_task/utils/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class AppButton extends StatelessWidget {
  final String label;
  final Function()? onTap;
  final bool expanded;
  final bool isLoading;
  final bool showBorder;
  late double height;
  final double borderRadius;
  final Color? bgColor;
  final Color? borderColor;
  final Color? textColor;
  late double fontSize;
  final FontWeight fontWeight;
  final EdgeInsets? padding;

  AppButton({
    super.key,
    required this.label,
    required this.onTap,
    this.isLoading = false,
    this.showBorder = true,
    double? height,
    this.borderRadius = 0,
    this.fontWeight = FontWeight.w400,
    this.bgColor,
    this.borderColor,
    this.textColor,
    this.padding,
    double? fontSize,
  }) : expanded = false {
    this.height = height ?? 5.h;
    this.fontSize = fontSize ?? 15.5.sp;
  }

  AppButton.expanded({
    super.key,
    required this.label,
    required this.onTap,
    this.isLoading = false,
    this.showBorder = true,
    double? height,
    this.borderRadius = 0,
    this.bgColor,
    this.borderColor,
    this.textColor,
    this.padding,
    this.fontWeight = FontWeight.w400,
    double? fontSize,
  }) : expanded = true {
    this.height = height ?? 5.h;
    this.fontSize = fontSize ?? 15.5.sp;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: expanded ? 100.w : null,
      height: height,
      child: TextButton(
        onPressed: isLoading ? null : onTap,
        style: TextButton.styleFrom(
          padding: EdgeInsets.zero,
          backgroundColor: onTap != null
              ? bgColor ?? appThemeColors.colorPrimary
              : (bgColor ?? appThemeColors.colorPrimary).withOpacity(0.5),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
            side: showBorder
                ? BorderSide(
                    color: (borderColor ?? appThemeColors.colorPrimary).withOpacity(onTap == null ? 0.5 : 1.0),
                  )
                : BorderSide.none,
          ),
        ),
        child: isLoading
            ? SizedBox(
                height: 1.5.h,
                width: 1.5.h,
                child: CircularProgressIndicator(
                  color: textColor ?? appThemeColors.onPrimary,
                  strokeWidth: 0.75.w,
                ),
              )
            : Padding(
                padding: padding ?? EdgeInsets.symmetric(horizontal: 3.w),
                child: Text(
                  label,
                  style: AppTextStyles.freeStyle(
                    color: (textColor ?? appThemeColors.onPrimary).withOpacity(onTap == null ? 0.5 : 1.0),
                    fontSize: fontSize,
                    fontWeight: fontWeight,
                  ),
                ),
              ),
      ),
    );
  }
}
