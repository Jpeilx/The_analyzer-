

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:the_analyzer/core/utils/colors/app_colors.dart';
import 'package:the_analyzer/core/utils/functions/repeated_functions.dart';
import 'package:the_analyzer/core/utils/helper/spacing.dart';
import 'package:the_analyzer/core/utils/styles/my_text.dart';
import 'package:the_analyzer/core/widget/cached_nework_image.dart';
import 'package:the_analyzer/core/widget/my_contianer_shape.dart';
import 'package:the_analyzer/features/search_free/logic/free_search_result_cubit/search_result_cubit.dart';
import 'package:the_analyzer/features/search_free/logic/free_search_result_cubit/search_result_state.dart';
import 'package:the_analyzer/features/search_free/views/widgets/line_chart_widget.dart';
import 'package:the_analyzer/features/search_free/views/widgets/negative_tweets_list_view.dart';
import 'package:the_analyzer/features/search_free/views/widgets/pie_chart_widget.dart';
import 'package:the_analyzer/features/search_free/views/widgets/positive_tweets_list_view.dart';
class FreeFreeSearchResultScreen extends StatelessWidget {
  const FreeFreeSearchResultScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
        child: ListView(
          children: [
            const FreePieChartWidget(),
            verticalSpace(20),
            const FreeLineChartWidget(),
            verticalSpace(20),
            MyText(title: "Positive Tweets"  , color: AppColors.baseColor, ) ,
            verticalSpace(10),
            const PositiveFreeTweetsListView(),
            verticalSpace(20),
             MyText(title: "Negative Tweets"  , color: AppColors.red, ) ,
            verticalSpace(10),
            const NegativeFreeTweetsListView() ,
            BlocConsumer<FreeSearchResultCubit, FreeSearchResultStates>(
              buildWhen: (previous, current) =>
                  current is GetFreePositaveWorrdsImagesErrorState ||
                  current is GetFreePositaveWorrdsImagesLoadingState ||
                  current is GetFreePositaveWorrdsImagesSuccessState,
              listenWhen: (previous, current) =>
                  current is GetFreePositaveWorrdsImagesErrorState ||
                  current is GetFreePositaveWorrdsImagesLoadingState ||
                  current is GetFreePositaveWorrdsImagesSuccessState,
              listener: (context, state) {
                if (state is GetFreePositaveWorrdsImagesErrorState) {
                  RepeatedFunctions.showSnackBar(context,
                      message: state.message, error: true);
                }
              },
              builder: (context, state) {
                if (state is GetFreePositaveWorrdsImagesLoadingState) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (state is GetFreePositaveWorrdsImagesErrorState) {
                  return Text('error');
                }

                return MyContainerShape(
                    width: double.infinity,
                    height: 250.h,
                    topEndRaduis: 10,
                    topStartRaduis: 10,
                    bottomEndRaduis: 10,
                    bottomStartRaduis: 10,
                    child: Container(
                        clipBehavior: Clip.antiAlias,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16.r),
                        ),
                        child: CachedImage(
                          url:
                              FreeSearchResultCubit.get(context).positiveImageUrl ??
                                  '',
                          width: double.infinity,
                          height: 250.h,
                          boxShap: BoxShape.rectangle,
                        )));
              },
            ),
            verticalSpace(20),
            BlocConsumer<FreeSearchResultCubit, FreeSearchResultStates>(
              buildWhen: (previous, current) =>
                  current is GetFreeNegativeWorrdsImagesErrorState ||
                  current is GetFreeNegativeWorrdsImagesLoadingState ||
                  current is GetFreeNegativeWorrdsImagesSuccessState,
              listenWhen: (previous, current) =>
                  current is GetFreeNegativeWorrdsImagesErrorState ||
                  current is GetFreeNegativeWorrdsImagesLoadingState ||
                  current is GetFreeNegativeWorrdsImagesSuccessState,
              listener: (context, state) {
                if (state is GetFreeNegativeWorrdsImagesErrorState) {
                  RepeatedFunctions.showSnackBar(context,
                      message: state.message, error: true);
                }
              },
              builder: (context, state) {
                if (state is GetFreeNegativeWorrdsImagesLoadingState) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (state is GetFreeNegativeWorrdsImagesErrorState) {
                  return Text('error');
                }

                return MyContainerShape(
                    width: double.infinity,
                    height: 250.h,
                    topEndRaduis: 10,
                    topStartRaduis: 10,
                    bottomEndRaduis: 10,
                    bottomStartRaduis: 10,
                    child: Container(
                        clipBehavior: Clip.antiAlias,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16.r),
                        ),
                        child: CachedImage(
                          url:
                              FreeSearchResultCubit.get(context).negativeImageUrl ??
                                  '',
                          width: double.infinity,
                          height: 250.h,
                          boxShap: BoxShape.rectangle,
                        )));
              },
            ),
          ],
        ),
      ),
    );
  }
}
