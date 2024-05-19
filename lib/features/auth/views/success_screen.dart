import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';
import 'package:the_analyzer/core/utils/colors/app_colors.dart';
import 'package:the_analyzer/core/utils/routes/app_router.dart';
import 'package:the_analyzer/core/utils/styles/my_text.dart';
import 'package:the_analyzer/core/widget/my_elevated_button.dart';

class SuccessScreen extends StatelessWidget {
  const SuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 26.w),
        child: Column(
          children: [
            SizedBox(
              height: 111.h,
              width: double.infinity,
            ),
            SizedBox(height: 30.h),
            LottieBuilder.asset('assets/images/icon_json/ic_success.json'),
            MyText(
              title: "Reset Password",
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
            SizedBox(height: 10.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 25.w),
              child: MyText(
                title:
                    "your password has been successfully reset click below to login",
                fontSize: 12,
                fontWeight: FontWeight.w400,
                color: AppColors.gray,
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: 50.h),
            MyElevatedButton(
              title: 'continue',
              fontSize: 18,
              onPressed: () {
                GoRouter.of(context).go(AppRouter.kLoginByEmailView);
              },
            ),
          ],
        ),
      ),
    );
  }
}
