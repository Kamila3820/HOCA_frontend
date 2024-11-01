import 'package:json_annotation/json_annotation.dart';

part 'ratingmetrics.g.dart';

@JsonSerializable()
class RatingMetrics {
  @JsonKey(name: 'total_score')
  final double? totalScore;

  @JsonKey(name: 'avg_work_score')
  final double? avgWork;

  @JsonKey(name: 'avg_security_score')
  final double? avgSecurity;

  @JsonKey(name: 'total_rating')
  final int? totalRating;

  @JsonKey(name: 'max_score')
  final double? maxScore;

  @JsonKey(name: 'min_score')
  final double? minScore;

  RatingMetrics(
      {required this.avgSecurity,
      required this.avgWork,
      required this.maxScore,
      required this.minScore,
      required this.totalRating,
      required this.totalScore,
      });

  factory RatingMetrics.fromJson(Map<String, dynamic> json) => _$RatingMetricsFromJson(json);

  Map<String, dynamic> toJson() => _$RatingMetricsToJson(this);
}