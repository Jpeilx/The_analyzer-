import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:the_analyzer/core/constant/assets_data.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: LottieBuilder.asset(
        AssetsData.loadingAnimations,
        width: 200.r,
      ),
    );
  }
}
