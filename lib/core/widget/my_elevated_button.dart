import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:the_analyzer/core/utils/colors/app_colors.dart';
import 'package:the_analyzer/core/utils/styles/my_text.dart';

// ignore: must_be_immutable
class MyElevatedButton extends StatelessWidget {
  String title;
  VoidCallback? onPressed;
  double fontSize;
  Color? titleColor;
  FontWeight fontWeight;
  Color borderColor;
  Color? background;
  double borderWidth;
  double height;
  double width;
  double borderRaduis;
  bool enabledBorder;
  double? elevation;
  String? iconPath;
  bool iconStart;
  double marginStart;
  EdgeInsets? padding;

  MyElevatedButton({
    Key? key,
    required this.title,
    this.onPressed,
    this.fontSize = 24,
    this.titleColor = AppColors.white,
    this.fontWeight = FontWeight.w400,
    this.borderColor = AppColors.tansparent,
    this.background,
    this.borderWidth = 1,
    this.height = 48,
    this.borderRaduis = 10,
    this.width = 176,
    this.enabledBorder = true,
    this.elevation,
    this.iconPath,
    this.iconStart = true,
    this.marginStart = 0,
    this.padding,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ButtonStyle(
        padding: MaterialStateProperty.all(padding ?? EdgeInsets.zero),
        minimumSize: MaterialStateProperty.all(Size(width.w, height.h)),
        shadowColor: MaterialStateProperty.resolveWith<Color?>(
            (states) => AppColors.tansparent),
        backgroundColor: MaterialStateProperty.resolveWith<Color?>(
            (states) => background ?? AppColors.baseColor),
        elevation:
            MaterialStateProperty.resolveWith<double?>((states) => elevation),
        shape: MaterialStateProperty.resolveWith(
          (states) {
            if (states.contains(MaterialState.pressed)) {
              return RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(borderRaduis.r),
                side: BorderSide(
                  color: AppColors.baseColor,
                  width: borderWidth,
                ),
              );
            }
            if (states.contains(MaterialState.hovered)) {
              return RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(borderRaduis.r),
                side: BorderSide(
                  color: AppColors.baseColor,
                  width: borderWidth,
                ),
              );
            }
            return RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(borderRaduis.r),
              side: BorderSide(
                color: borderColor,
                width: borderWidth,
              ),
            );
          },
        ),
      ),
      child: marginStart == 0
          ? Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (iconStart)
                  if (iconPath != null) ...[
                    SvgPicture.asset(
                      iconPath!,
                      width: 24.r,
                      height: 24.r,
                    ),
                    SizedBox(width: 10.w),
                  ],
                MyText(
                  title: title,
                  fontSize: fontSize,
                  color: titleColor,
                  fontWeight: fontWeight,
                  textAlign: TextAlign.center,
                ),
                if (!iconStart)
                  if (iconPath != null) ...[
                    SizedBox(width: 10.w),
                    SvgPicture.asset(
                      iconPath!,
                      width: 24.r,
                      height: 24.r,
                    ),
                  ],
              ],
            )
          : Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(width: marginStart.w),
                if (iconStart)
                  if (iconPath != null) ...[
                    SvgPicture.asset(
                      iconPath!,
                      width: 24.r,
                      height: 24.r,
                    ),
                    SizedBox(width: 10.w),
                  ],
                MyText(
                  title: title,
                  fontSize: fontSize,
                  color: titleColor,
                  fontWeight: fontWeight,
                  textAlign: TextAlign.center,
                ),
                if (!iconStart)
                  if (iconPath != null) ...[
                    SizedBox(width: 10.w),
                    SvgPicture.asset(
                      iconPath!,
                      width: 24.r,
                      height: 24.r,
                    ),
                  ],
              ],
            ),
    );
  }
}
