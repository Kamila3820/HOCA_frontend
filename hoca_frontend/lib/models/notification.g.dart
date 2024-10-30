// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Notifications _$NotificationsFromJson(Map<String, dynamic> json) =>
    Notifications(
      notiID: (json['id'] as num?)?.toInt(),
      userID: json['user_id'] as String?,
      username: json['username'] as String?,
      avatar: json['avatar'] as String?,
      triggerID: json['trigger_id'] as String?,
      order: json['order'] == null
          ? null
          : NotificationOrder.fromJson(json['order'] as Map<String, dynamic>),
      orderID: (json['order_id'] as num?)?.toInt(),
      rating: json['user_rating'] == null
          ? null
          : NotificationRating.fromJson(
              json['user_rating'] as Map<String, dynamic>),
      ratingID: (json['user_rating_id'] as num?)?.toInt(),
      type: json['type'] as String?,
    );

Map<String, dynamic> _$NotificationsToJson(Notifications instance) =>
    <String, dynamic>{
      'id': instance.notiID,
      'user_id': instance.userID,
      'username': instance.username,
      'avatar': instance.avatar,
      'trigger_id': instance.triggerID,
      'order': instance.order,
      'order_id': instance.orderID,
      'user_rating': instance.rating,
      'user_rating_id': instance.ratingID,
      'type': instance.type,
    };
