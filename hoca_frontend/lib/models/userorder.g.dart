// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'userorder.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserOrder _$UserOrderFromJson(Map<String, dynamic> json) => UserOrder(
      id: (json['id'] as num).toInt(),
      userID: json['user_id'] as String?,
      price: (json['price'] as num?)?.toDouble(),
      payment: json['payment_type'] as String?,
      postID: (json['worker_post_id'] as num?)?.toInt(),
      status: json['order_status'] as String?,
      workerName: json['worker_name'] as String?,
      workerPhone: json['worker_phone'] as String?,
      workerAvatar: json['worker_avatar'] as String?,
    );

Map<String, dynamic> _$UserOrderToJson(UserOrder instance) => <String, dynamic>{
      'id': instance.id,
      'user_id': instance.userID,
      'worker_post_id': instance.postID,
      'worker_name': instance.workerName,
      'worker_phone': instance.workerPhone,
      'worker_avatar': instance.workerAvatar,
      'payment_type': instance.payment,
      'order_status': instance.status,
      'price': instance.price,
    };
