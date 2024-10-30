// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'history.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

History _$HistoryFromJson(Map<String, dynamic> json) => History(
      historyID: (json['id'] as num).toInt(),
      userID: json['user_id'] as String?,
      orderID: json['order_id'] as String?,
      status: json['status'] as String?,
      isRated: json['is_rated'] as bool?,
      cancellationReason: json['cancellation_reason'] as String?,
      cancelledBy: json['cancelled_by'] as String?,
      name: json['name'] as String?,
      price: (json['price'] as num?)?.toDouble(),
      createdAt: json['created_at'] as String?,
    );

Map<String, dynamic> _$HistoryToJson(History instance) => <String, dynamic>{
      'id': instance.historyID,
      'user_id': instance.userID,
      'order_id': instance.orderID,
      'status': instance.status,
      'is_rated': instance.isRated,
      'cancellation_reason': instance.cancellationReason,
      'cancelled_by': instance.cancelledBy,
      'name': instance.name,
      'price': instance.price,
      'created_at': instance.createdAt,
    };
