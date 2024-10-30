import 'package:hoca_frontend/models/notificationorder.dart';
import 'package:hoca_frontend/models/notificationrating.dart';
import 'package:json_annotation/json_annotation.dart';

part 'notification.g.dart';

@JsonSerializable()
class Notifications {
  @JsonKey(name: 'id')
  final int? notiID;

  @JsonKey(name: 'user_id')
  final String? userID;

  @JsonKey(name: 'username')
  final String? username;

  @JsonKey(name: 'avatar')
  final String? avatar;

  @JsonKey(name: 'trigger_id')
  final String? triggerID;

  @JsonKey(name: 'order')
  final NotificationOrder? order;

  @JsonKey(name: 'order_id')
  final int? orderID;

  @JsonKey(name: 'user_rating')
  final NotificationRating? rating;

  @JsonKey(name: 'user_rating_id')
  final int? ratingID;

  @JsonKey(name: 'type')
  final String? type;

  Notifications({
    required this.notiID,
    required this.userID,
    required this.username,
    required this.avatar,
    required this.triggerID,
    required this.order,
    required this.orderID,
    required this.rating,
    required this.ratingID,
    required this.type,
  });

  factory Notifications.fromJson(Map<String, dynamic> json) =>
      _$NotificationsFromJson(json);

  Map<String, dynamic> toJson() => _$NotificationsToJson(this);
}