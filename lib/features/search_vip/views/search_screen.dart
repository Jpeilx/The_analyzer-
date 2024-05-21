import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';
import 'package:the_analyzer/core/constant/app_constance.dart';
import 'package:the_analyzer/core/constant/assets_data.dart';
import 'package:the_analyzer/core/network/local/handle_save_latest_search_data.dart';
import 'package:the_analyzer/core/utils/colors/app_colors.dart';
import 'package:the_analyzer/core/utils/routes/app_router.dart';
import 'package:the_analyzer/core/utils/styles/my_text.dart';
import 'package:the_analyzer/core/widget/loading_widget.dart';
import 'package:the_analyzer/features/search_vip/logic/search_cubit/search_cubit.dart';
import 'package:the_analyzer/features/search_vip/views/widgets/my_search_view.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  String strSearch = '';
  TextEditingController searchController = TextEditingController();

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: MyText(
          title: 'Soci-Eye',
          fontSize: 20,
        ),
      ),
      body: BlocConsumer<SearchCubit, SearchStates>(
        listener: (context, state) {
          if (state is MakeSearchSuccessState) {
            GoRouter.of(context).push(AppRouter.kSearchResultView);
          }
        },
        builder: (context, state) {
          if (state is MakeSearchLoadingState) return LoadingWidget();
          return SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 20.h),
                  IgnorePointer(
                    ignoring: AppConstance.isVIP == false,
                    child: MySearchView(
                      hint: "Search about company here ",
                      controller: searchController,
                      onFieldSubmitted: (data) {
                        addToLatestSearch(data);
                        SearchCubit.get(context)
                            .searchAboutProduct(searchData: data);
                      },
                    ),
                  ),
                  SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        if (AppConstance.isVIP == false) ...[
                          SizedBox(
                            height: 20.h,
                            width: double.infinity,
                          ),
                          MyText(
                            title: 'you can search about',
                            fontSize: 18,
                            color: AppColors.baseColor,
                          ),
                          SizedBox(height: 10.h),
                           InkWell(
                                  onTap: (){
                                    print('jj') ;
                                    GoRouter.of(context).push(AppRouter.kFreeSearchVeiw);
                                  },
                                  child: Container(
                                        margin: EdgeInsetsDirectional.only(
                                          end: 20.w,
                                          bottom: 20.h,
                                        ),
                                        padding: EdgeInsets.symmetric(
                                          horizontal: 10.w,
                                          vertical: 8.h,
                                        ),
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(10.r),
                                          color:
                                              AppColors.baseColor.withOpacity(.1),
                                        ),
                                        child: MyText(
                                          title: "starbuks",
                                          fontSize: 14,
                                        ),
                                      ),
                                ),
                          const Divider(height: 1, color: AppColors.border),
                        ],
                        SizedBox(height: 20.h),
                        if (getLatestSearchData().isNotEmpty && AppConstance.isVIP == true ) ...[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              MyText(
                                title: 'history',
                                fontSize: 18,
                                color: AppColors.baseColor,
                              ),
                              InkWell(
                                onTap: () {
                                  setState(() {
                                    deleteAllLatestSearchData();
                                  });
                                },
                                child: MyText(
                                  title: 'Delete All ',
                                  fontSize: 14,
                                  color: AppColors.red,
                                ),
                              ),
                            ],
                          ),
                          ListView.builder(
                            itemCount: getLatestSearchData().length,
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              return InkWell(
                                onTap: () {
                                  strSearch = getLatestSearchData()[index];
                                  searchController.text = strSearch;
                                  SearchCubit.get(context)
                                      .searchAboutProduct(searchData: strSearch);
                                },
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    MyText(
                                      title: getLatestSearchData()[index],
                                    ),
                                    IconButton(
                                      onPressed: () {
                                        setState(() {
                                          deleteElementFormLatestSearchData(
                                              '${index + 1}');
                                        });
                                      },
                                      icon: const Icon(
                                        Icons.close,
                                        color: AppColors.red,
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ],
                       const SizedBox(height: 100,) ,
                       AppConstance.isVIP == false  ?  const SizedBox(height: 200,) : const  SizedBox() ,
                        AppConstance.isVIP == false 
                            ? TextButton(
                                onPressed: () {
                                  GoRouter.of(context).push(AppRouter.kSubscribtionView);
                                },
                                child: MyText(
                                  title: 'subscribe to have custom search',
                                  fontSize: 18,
                                  color: AppColors.baseColor,
                                ))
                            : const SizedBox(),
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class NoSearchWidget extends StatelessWidget {
  const NoSearchWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(height: 30.h),
        LottieBuilder.asset(
          AssetsData.noSearchResult,
          width: 200.r,
        ),
        SizedBox(height: 30.h),
        MyText(
          title: 'No Result Found',
          fontSize: 20,
        ),
      ],
    );
  }
}
