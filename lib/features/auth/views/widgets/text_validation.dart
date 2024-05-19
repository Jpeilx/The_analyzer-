import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:the_analyzer/core/utils/colors/app_colors.dart';
import 'package:the_analyzer/core/utils/styles/my_text.dart';

class TextValidation extends StatelessWidget {
  final bool success;
  final String title;

  const TextValidation({
    Key? key,
    required this.success,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          success ? Icons.check : Icons.close,
          size: 14.r,
          color: success ? AppColors.navyBlue : AppColors.red,
        ),
        SizedBox(width: 8.w),
        MyText(
          title: title,
          color: success ? AppColors.navyBlue : AppColors.red,
          fontSize: 12,
          fontWeight: FontWeight.w400,
        )
      ],
    );
  }
}
