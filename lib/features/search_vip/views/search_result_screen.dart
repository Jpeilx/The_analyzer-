import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:the_analyzer/core/utils/colors/app_colors.dart';
import 'package:the_analyzer/core/utils/functions/repeated_functions.dart';
import 'package:the_analyzer/core/utils/helper/spacing.dart';
import 'package:the_analyzer/core/utils/styles/my_text.dart';
import 'package:the_analyzer/core/widget/cached_nework_image.dart';
import 'package:the_analyzer/core/widget/my_contianer_shape.dart';
import 'package:the_analyzer/features/search_free/views/widgets/negative_tweets_list_view.dart';
import 'package:the_analyzer/features/search_vip/logic/search_result_cubit/search_result_cubit.dart';
import 'package:the_analyzer/features/search_vip/views/widgets/line_chart_widget.dart';
import 'package:the_analyzer/features/search_vip/views/widgets/negative_tweets_list_view.dart';
import 'package:the_analyzer/features/search_vip/views/widgets/pie_chart_widget.dart';
import 'package:the_analyzer/features/search_vip/views/widgets/positive_tweets_list_view.dart';

class SearchResultScreen extends StatelessWidget {
  const SearchResultScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
        child: ListView(
          children: [
            const PieChartWidget(),
            verticalSpace(20),
            const LineChartWidget(),
            verticalSpace(20),
            MyText(title: "Positive Tweets"  , color: AppColors.baseColor, ) ,
            verticalSpace(10),

            const PositiveTweetsListView(),
            verticalSpace(20),
            MyText(title: "Negative Tweets"  , color: AppColors.red, ) ,
            const  NegativeFreeTweetsListView() ,
            verticalSpace(10),
            const NegativeTweetsListVeiw(),
            BlocConsumer<SearchResultCubit, SearchResultStates>(
              buildWhen: (previous, current) =>
                  current is GetPositaveWorrdsImagesErrorState ||
                  current is GetPositaveWorrdsImagesLoadingState ||
                  current is GetPositaveWorrdsImagesSuccessState,
              listenWhen: (previous, current) =>
                  current is GetPositaveWorrdsImagesErrorState ||
                  current is GetPositaveWorrdsImagesLoadingState ||
                  current is GetPositaveWorrdsImagesSuccessState,
              listener: (context, state) {
                if (state is GetPositaveWorrdsImagesErrorState) {
                  RepeatedFunctions.showSnackBar(context,
                      message: state.message, error: true);
                }
              },
              builder: (context, state) {
                if (state is GetPositaveWorrdsImagesLoadingState) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (state is GetPositaveWorrdsImagesErrorState) {
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
                              SearchResultCubit.get(context).positiveImageUrl ??
                                  '',
                          width: double.infinity,
                          height: 250.h,
                          boxShap: BoxShape.rectangle,
                        )));
              },
            ),
            verticalSpace(20),
            BlocConsumer<SearchResultCubit, SearchResultStates>(
              buildWhen: (previous, current) =>
                  current is GetNegativeWorrdsImagesErrorState ||
                  current is GetNegativeWorrdsImagesLoadingState ||
                  current is GetNegativeWorrdsImagesSuccessState,
              listenWhen: (previous, current) =>
                  current is GetNegativeWorrdsImagesErrorState ||
                  current is GetNegativeWorrdsImagesLoadingState ||
                  current is GetNegativeWorrdsImagesSuccessState,
              listener: (context, state) {
                if (state is GetNegativeWorrdsImagesErrorState) {
                  RepeatedFunctions.showSnackBar(context,
                      message: state.message, error: true);
                }
              },
              builder: (context, state) {
                if (state is GetNegativeWorrdsImagesLoadingState) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (state is GetNegativeWorrdsImagesErrorState) {
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
                              SearchResultCubit.get(context).negativeImageUrl ??
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
