
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_analyzer/core/utils/functions/repeated_functions.dart';
import 'package:the_analyzer/core/utils/helper/spacing.dart';
import 'package:the_analyzer/features/search_free/logic/free_search_result_cubit/search_result_cubit.dart';
import 'package:the_analyzer/features/search_free/logic/free_search_result_cubit/search_result_state.dart';
import 'package:the_analyzer/features/search_vip/views/widgets/tweet_widget.dart';

class NegativeFreeTweetsListView extends StatelessWidget {
  const NegativeFreeTweetsListView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FreeSearchResultCubit , FreeSearchResultStates>(
      buildWhen: (previous, current) =>
          current is GetTweetsSampleDataFreeErrorState ||
          current is GetTweetsSampleDataFreeLoadingState ||
          current is GetTweetsSampleDataFreeSuccessState,
      listenWhen: (previous, current) =>
          current is GetTweetsSampleDataFreeErrorState ||
          current is GetTweetsSampleDataFreeLoadingState ||
          current is GetTweetsSampleDataFreeSuccessState,
      listener: (context, state) {
        if (state is GetPercentageDataFreeErrorState) {
          RepeatedFunctions.showSnackBar(context,
              message: state.message, error: true);
        }
      },
      builder: (context, state) {
        if (state is GetTweetsSampleDataFreeLoadingState) {
          return const Center(child: CircularProgressIndicator());
        }
        if (state is GetTweetsSampleDataFreeErrorState) {
          return Text('error');
        }

        return ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) => TweetBox(
            profileImageUrl: 'https://example.com/profile.jpg',
            username: 'Xuser',
            handle: 'xuser',
            timestamp:
                '${ FreeSearchResultCubit.get(context).tweetsSampleDataFree?.negativeTweets?[index].time}',
            content:
                '${FreeSearchResultCubit.get(context).tweetsSampleDataFree?.negativeTweets?[index].text}',
          ),
          separatorBuilder: (BuildContext context, int index) =>
              verticalSpace(20),
          itemCount: FreeSearchResultCubit.get(context)
                  .tweetsSampleDataFree
                  ?.negativeTweets
                  ?.length ??
              0,
        );
      },
    );
  }
}
