import 'package:json_annotation/json_annotation.dart';

part 'notificationrating.g.dart';

@JsonSerializable()
class NotificationRating {

  @JsonKey(name: 'user_rating_id')
  final int? ratingID;

  NotificationRating({
    required this.ratingID,
  });

  factory NotificationRating.fromJson(Map<String, dynamic> json) =>
      _$NotificationRatingFromJson(json);

  Map<String, dynamic> toJson() => _$NotificationRatingToJson(this);
}