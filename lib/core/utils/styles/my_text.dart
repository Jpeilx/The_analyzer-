// ignore_for_file: must_be_immutable

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:the_analyzer/core/utils/colors/app_colors.dart';

class MyText extends StatelessWidget {
  String title;
  Color? color;
  double fontSize;
  double height;
  FontWeight fontWeight;
  TextAlign textAlign;
  bool lineThrough;
  bool typeLineThrough;
  bool textOverflow;
  int? maxLines;

  MyText({
    Key? key,
    required this.title,
    this.color = AppColors.black,
    this.fontSize = 16,
    this.height = 1.4,
    this.fontWeight = FontWeight.w500,
    this.textAlign = TextAlign.start,
    this.lineThrough = false,
    this.textOverflow = true,
    this.typeLineThrough = false,
    this.maxLines,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      textAlign: textAlign,
      overflow: textOverflow ? TextOverflow.ellipsis : null,
      maxLines: maxLines,
      style: TextStyle(
        color: color,
        fontSize: fontSize.sp,
        fontWeight: fontWeight,
        fontFamily: 'Poppins',
        height: height,
        decorationThickness: 1,
        decoration: lineThrough
            ? typeLineThrough
                ? TextDecoration.lineThrough
                : TextDecoration.underline
            : null,
      ),
    );
  }
}
