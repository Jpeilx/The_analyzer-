import 'package:expandable_page_view/expandable_page_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:the_analyzer/core/utils/colors/app_colors.dart';
import 'package:the_analyzer/core/utils/routes/app_router.dart';
import 'package:the_analyzer/core/utils/styles/my_text.dart';
import 'package:the_analyzer/core/widget/my_contianer_shape.dart';
import 'package:the_analyzer/core/widget/my_elevated_button.dart';
import 'package:the_analyzer/features/on_boarding/logic/on_boarding_cubit/on_boarding_cubit.dart';
import 'package:the_analyzer/features/on_boarding/views/widgets/my_indecators_pageview.dart';
import 'package:the_analyzer/features/on_boarding/views/widgets/my_page_view.dart';

class OnBoardingScreen extends StatelessWidget {
  final PageController controller = PageController();
  final PageController controller2 = PageController();
  OnBoardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PositionedDirectional(
            top: 0,
            start: 0,
            end: 0,
            child: SizedBox(
              width: double.infinity,
              height: 500.h,
              child: MyPageView(
                controller: controller,
                controller2: controller2,
              ),
            ),
          ),
          PositionedDirectional(
            bottom: 0,
            start: 0,
            end: 0,
            child: SizedBox(
              width: double.infinity,
              height: 500.h,
              child: MyContainerShape(
                borderRadius: 0,
                topEndRaduis: 300,
                topStartRaduis: 300,
                child: Column(
                  children: [
                    SizedBox(height: 50.h),
                    ExpandablePageView.builder(
                      controller: controller2,
                      itemCount: OnBoardingCubit.get(context)
                          .listDataOnBoarding
                          .length,
                      onPageChanged: (int index) {
                        OnBoardingCubit.get(context).changeIndexPageView(index);
                        controller.animateToPage(index,
                            duration: Duration(milliseconds: 300),
                            curve: Curves.ease);
                      },
                      itemBuilder: (BuildContext context, int index) {
                        return Column(
                          children: [
                            MyText(
                              title: OnBoardingCubit.get(context)
                                  .listDataOnBoarding[index]
                                  .title,
                              fontWeight: FontWeight.w600,
                            ),
                            SizedBox(height: 20.h),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 55.w),
                              child: MyText(
                                title: OnBoardingCubit.get(context)
                                    .listDataOnBoarding[index]
                                    .desc,
                                fontWeight: FontWeight.w400,
                                fontSize: 12,
                                color: AppColors.gray,
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                    SizedBox(height: 30.h),
                    const MyIndecatorsPageView(),
                    const Expanded(child: SizedBox()),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 26.w),
                      child: BlocBuilder<OnBoardingCubit, OnBoardingState>(
                        builder: (context, state) {
                          return Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              MyElevatedButton(
                                title: 'Sign Up',
                                onPressed: () {
                                  OnBoardingCubit.get(context)
                                      .changeSelectButton(1);
                                  GoRouter.of(context)
                                      .push(AppRouter.kSignUpByEmailView);
                                },
                                background: OnBoardingCubit.get(context)
                                            .indexSelectedButton ==
                                        0
                                    ? AppColors.tansparent
                                    : AppColors.baseColor,
                                titleColor: OnBoardingCubit.get(context)
                                            .indexSelectedButton ==
                                        0
                                    ? AppColors.black
                                    : AppColors.white,
                                borderColor: OnBoardingCubit.get(context)
                                            .indexSelectedButton ==
                                        0
                                    ? AppColors.border
                                    : AppColors.tansparent,
                              ),
                              SizedBox(height: 30.h),
                              MyElevatedButton(
                                title: 'Sign In',
                                onPressed: () {
                                  OnBoardingCubit.get(context)
                                      .changeSelectButton(0);
                                  GoRouter.of(context)
                                      .push(AppRouter.kLoginByEmailView);
                                },
                                background: OnBoardingCubit.get(context)
                                            .indexSelectedButton ==
                                        1
                                    ? AppColors.tansparent
                                    : AppColors.baseColor,
                                titleColor: OnBoardingCubit.get(context)
                                            .indexSelectedButton ==
                                        1
                                    ? AppColors.black
                                    : AppColors.white,
                                borderColor: OnBoardingCubit.get(context)
                                            .indexSelectedButton ==
                                        1
                                    ? AppColors.border
                                    : AppColors.tansparent,
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                    SizedBox(height: 20.h),
                    SizedBox(height: 50.h),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
