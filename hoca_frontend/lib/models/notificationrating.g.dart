// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notificationrating.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NotificationRating _$NotificationRatingFromJson(Map<String, dynamic> json) =>
    NotificationRating(
      ratingID: (json['user_rating_id'] as num?)?.toInt(),
    );

Map<String, dynamic> _$NotificationRatingToJson(NotificationRating instance) =>
    <String, dynamic>{
      'user_rating_id': instance.ratingID,
    };
