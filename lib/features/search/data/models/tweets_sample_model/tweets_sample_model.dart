import 'package:equatable/equatable.dart';

import 'negative_tweet.dart';
import 'positive_tweet.dart';

class TweetsSampleModel extends Equatable {
  final List<PositiveTweet>? positiveTweets;
  final List<NegativeTweet>? negativeTweets;

  const TweetsSampleModel({this.positiveTweets, this.negativeTweets});

  factory TweetsSampleModel.fromJson(Map<String, dynamic> json) {
    return TweetsSampleModel(
      positiveTweets: (json['positive_tweets'] as List<dynamic>?)
          ?.map((e) => PositiveTweet.fromJson(e as Map<String, dynamic>))
          .toList(),
      negativeTweets: (json['negative_tweets'] as List<dynamic>?)
          ?.map((e) => NegativeTweet.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
        'positive_tweets': positiveTweets?.map((e) => e.toJson()).toList(),
        'negative_tweets': negativeTweets?.map((e) => e.toJson()).toList(),
      };

  TweetsSampleModel copyWith({
    List<PositiveTweet>? positiveTweets,
    List<NegativeTweet>? negativeTweets,
  }) {
    return TweetsSampleModel(
      positiveTweets: positiveTweets ?? this.positiveTweets,
      negativeTweets: negativeTweets ?? this.negativeTweets,
    );
  }

  @override
  List<Object?> get props => [positiveTweets, negativeTweets];
}
