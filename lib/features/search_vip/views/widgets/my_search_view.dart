import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:the_analyzer/core/constant/assets_data.dart';
import 'package:the_analyzer/core/utils/colors/app_colors.dart';
import 'package:the_analyzer/core/widget/my_text_field.dart';

class MySearchView extends StatelessWidget {
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final bool isScanBarcode;
  final String hint;
  final bool autofocus;
  final Function(String)? onChange;
  final Function(String)? onFieldSubmitted;
  final Function()? onTapBarcode;
  final Function()? onTap;
  final bool readOnly;

  const MySearchView({
    Key? key,
    this.isScanBarcode = false,
    this.controller,
    this.focusNode,
    this.onChange,
    this.autofocus = false,
    this.onTap,
    this.onFieldSubmitted,
    this.onTapBarcode,
    required this.hint,
    this.readOnly = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MyTextField(
      readOnly: readOnly,
      controller: controller,
      textHint: hint,
      isBorder: true,
      paddingHorizontal: 16,
      focusNode: focusNode,
      fontSize: 15,
      onChange: onChange,
      autofocus: autofocus,
      maxLines: 1,
      minLines: 1,
      onTap: onTap,
      onFieldSubmitted: onFieldSubmitted,
      hintColor: AppColors.gray,
      prefixIcon: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(width: 16.w),
          SvgPicture.asset(
            AssetsData.searchNormalIcon,
            width: 26.r,
          ),
          SizedBox(width: 10.w),
        ],
      ),
    );
  }
}
