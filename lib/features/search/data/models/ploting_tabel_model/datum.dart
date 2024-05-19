import 'package:equatable/equatable.dart';

class Datum extends Equatable {
  final String? x;
  final int? y;

  const Datum({this.x, this.y});

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        x: json['x'] as String?,
        y: json['y'] as int?,
      );

  Map<String, dynamic> toJson() => {
        'x': x,
        'y': y,
      };

  @override
  List<Object?> get props => [x, y];
}
