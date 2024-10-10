// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'userrating.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserRating _$UserRatingFromJson(Map<String, dynamic> json) => UserRating(
      ratingID: (json['id'] as num).toInt(),
      userID: json['user_id'] as String?,
      username: json['username'] as String?,
      avatarUrl: json['avatar'] as String?,
      workScore: (json['work_score'] as num?)?.toInt(),
      securityScore: (json['security_score'] as num?)?.toInt(),
      comment: json['comment'] as String?,
      createdAt: json['created_at'] as String?,
    );

Map<String, dynamic> _$UserRatingToJson(UserRating instance) =>
    <String, dynamic>{
      'id': instance.ratingID,
      'user_id': instance.userID,
      'username': instance.username,
      'avatar': instance.avatarUrl,
      'work_score': instance.workScore,
      'security_score': instance.securityScore,
      'comment': instance.comment,
      'created_at': instance.createdAt,
    };
