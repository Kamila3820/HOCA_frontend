// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ratingmetrics.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RatingMetrics _$RatingMetricsFromJson(Map<String, dynamic> json) =>
    RatingMetrics(
      avgSecurity: (json['avg_security_score'] as num?)?.toDouble(),
      avgWork: (json['avg_work_score'] as num?)?.toDouble(),
      maxScore: (json['max_score'] as num?)?.toDouble(),
      minScore: (json['min_score'] as num?)?.toDouble(),
      totalRating: (json['total_rating'] as num?)?.toInt(),
      totalScore: (json['total_score'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$RatingMetricsToJson(RatingMetrics instance) =>
    <String, dynamic>{
      'total_score': instance.totalScore,
      'avg_work_score': instance.avgWork,
      'avg_security_score': instance.avgSecurity,
      'total_rating': instance.totalRating,
      'max_score': instance.maxScore,
      'min_score': instance.minScore,
    };
