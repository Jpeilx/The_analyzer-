import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:the_analyzer/core/utils/colors/app_colors.dart';

class Indecatior extends StatelessWidget {
  final bool selected;
  const Indecatior({super.key, required this.selected});

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      width: selected ? 20.w : 10.w,
      height: 5.h,
      decoration: BoxDecoration(
        color: selected
            ? AppColors.baseColor
            : AppColors.baseColor.withOpacity(.2),
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }
}
