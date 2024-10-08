// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'userratings.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserRatings _$UserRatingsFromJson(Map<String, dynamic> json) => UserRatings(
      userratings: (json['userratings'] as List<dynamic>)
          .map((e) => UserRating.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$UserRatingsToJson(UserRatings instance) =>
    <String, dynamic>{
      'userratings': instance.userratings,
    };
