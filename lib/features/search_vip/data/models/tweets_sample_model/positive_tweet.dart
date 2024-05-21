import 'package:equatable/equatable.dart';

class PositiveTweet extends Equatable {
  final String? sentiment;
  final double? score;
  final String? text;
  final DateTime? time;
  final String? id;

  const PositiveTweet({
    this.sentiment,
    this.score,
    this.text,
    this.time,
    this.id,
  });

  factory PositiveTweet.fromJson(Map<String, dynamic> json) => PositiveTweet(
        sentiment: json['Sentiment'] as String?,
        score: (json['Score'] as num?)?.toDouble(),
        text: json['Text'] as String?,
        time: json['time'] == null
            ? null
            : DateTime.parse(json['time'] as String),
        id: json['_id'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'Sentiment': sentiment,
        'Score': score,
        'Text': text,
        'time': time?.toIso8601String(),
        '_id': id,
      };

  PositiveTweet copyWith({
    String? sentiment,
    double? score,
    String? text,
    DateTime? time,
    String? id,
  }) {
    return PositiveTweet(
      sentiment: sentiment ?? this.sentiment,
      score: score ?? this.score,
      text: text ?? this.text,
      time: time ?? this.time,
      id: id ?? this.id,
    );
  }

  @override
  List<Object?> get props => [sentiment, score, text, time, id];
}
