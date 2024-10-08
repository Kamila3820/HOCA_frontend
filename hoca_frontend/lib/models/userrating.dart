import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

part 'userrating.g.dart';

@JsonSerializable()
class UserRating {
  @JsonKey(name: 'id')
  final int ratingID;

  @JsonKey(name: 'user_id')
  final String userID;

  @JsonKey(name: 'username')
  final String username;

  @JsonKey(name: 'avatar')
  final String avatarUrl;

  @JsonKey(name: 'work_score')
  final int workScore;

  @JsonKey(name: 'security_score')
  final int securityScore;

  @JsonKey(name: 'comment')
  final String? comment;


  UserRating(
      {required this.ratingID,
      required this.userID,
      required this.username,
      required this.avatarUrl,
      required this.workScore,
      required this.securityScore,
      required this.comment
      });

  factory UserRating.fromJson(Map<String, dynamic> json) => _$UserRatingFromJson(json);

  Map<String, dynamic> toJson() => _$UserRatingToJson(this);
}