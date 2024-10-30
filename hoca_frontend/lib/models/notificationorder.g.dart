// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notificationorder.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NotificationOrder _$NotificationOrderFromJson(Map<String, dynamic> json) =>
    NotificationOrder(
      orderID: (json['order_id'] as num?)?.toInt(),
    );

Map<String, dynamic> _$NotificationOrderToJson(NotificationOrder instance) =>
    <String, dynamic>{
      'order_id': instance.orderID,
    };
