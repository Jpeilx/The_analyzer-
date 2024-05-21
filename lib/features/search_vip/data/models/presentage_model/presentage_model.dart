import 'package:equatable/equatable.dart';

class PresentageModel extends Equatable {
  final double? positivePercentage;
  final double? negativePercentage;

  const PresentageModel({this.positivePercentage, this.negativePercentage});

  factory PresentageModel.fromJson(Map<String, dynamic> json) {
    return PresentageModel(
      positivePercentage: (json['positive_percentage'] as num?)?.toDouble(),
      negativePercentage: (json['negative_percentage'] as num?)?.toDouble(),
    );
  }

  Map<String, dynamic> toJson() => {
        'positive_percentage': positivePercentage,
        'negative_percentage': negativePercentage,
      };

  PresentageModel copyWith({
    double? positivePercentage,
    double? negativePercentage,
  }) {
    return PresentageModel(
      positivePercentage: positivePercentage ?? this.positivePercentage,
      negativePercentage: negativePercentage ?? this.negativePercentage,
    );
  }

  @override
  List<Object?> get props => [positivePercentage, negativePercentage];
}
