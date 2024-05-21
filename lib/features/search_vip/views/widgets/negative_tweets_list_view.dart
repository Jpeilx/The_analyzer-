import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_analyzer/core/utils/functions/repeated_functions.dart';
import 'package:the_analyzer/core/utils/helper/spacing.dart';
import 'package:the_analyzer/features/search_vip/logic/search_result_cubit/search_result_cubit.dart';
import 'package:the_analyzer/features/search_vip/views/widgets/tweet_widget.dart';

class NegativeTweetsListVeiw extends StatelessWidget {
  const NegativeTweetsListVeiw({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SearchResultCubit, SearchResultStates>(
      buildWhen: (previous, current) =>
          current is GetTweetsSampleDataErrorState ||
          current is GetTweetsSampleDataLoadingState ||
          current is GetTweetsSampleDataSuccessState,
      listenWhen: (previous, current) =>
          current is GetTweetsSampleDataErrorState ||
          current is GetTweetsSampleDataLoadingState ||
          current is GetTweetsSampleDataSuccessState,
      listener: (context, state) {
        if (state is GetPercentageDataErrorState) {
          RepeatedFunctions.showSnackBar(context,
              message: state.message, error: true);
        }
      },
      builder: (context, state) {
        if (state is GetTweetsSampleDataLoadingState) {
          return const Center(child: CircularProgressIndicator());
        }
        if (state is GetTweetsSampleDataErrorState) {
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
                '${SearchResultCubit.get(context).tweetsSampleData?.negativeTweets?[index].time}',
            content:
                '${SearchResultCubit.get(context).tweetsSampleData?.negativeTweets?[index].text}',
          ),
          separatorBuilder: (BuildContext context, int index) =>
              verticalSpace(20),
          itemCount: SearchResultCubit.get(context)
                  .tweetsSampleData
                  ?.negativeTweets
                  ?.length ??
              0,
        );
      },
    );
  }
}
