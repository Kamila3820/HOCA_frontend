import 'package:json_annotation/json_annotation.dart';
import 'package:hoca_frontend/models/userrating.dart';

part 'userratings.g.dart';

@JsonSerializable()
class UserRatings {
  @JsonKey(name: 'userratings')
  final List<UserRating> userratings;

  UserRatings({
    required this.userratings,
  });
  factory UserRatings.fromJson(Map<String, dynamic> json) => _$UserRatingsFromJson(json);

  Map<String, dynamic> toJson() => _$UserRatingsToJson(this);
}