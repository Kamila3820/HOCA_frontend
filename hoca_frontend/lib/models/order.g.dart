// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Order _$OrderFromJson(Map<String, dynamic> json) => Order(
      id: (json['id'] as num).toInt(),
      userID: json['user_id'] as String?,
      contactName: json['contact_name'] as String?,
      contactPhone: json['contact_phone'] as String?,
      note: json['note'] as String?,
      specPlace: json['specific_place'] as String?,
      price: (json['price'] as num?)?.toDouble(),
      payment: json['payment_type'] as String?,
      postID: (json['worker_post_id'] as num?)?.toInt(),
      status: json['order_status'] as String?,
      isCancel: json['is_cancel'] as bool?,
      cancelReason: json['cancellation_reason'] as String?,
      cancelBy: json['cancelled_by'] as String?,
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
    );

Map<String, dynamic> _$OrderToJson(Order instance) => <String, dynamic>{
      'id': instance.id,
      'user_id': instance.userID,
      'worker_post_id': instance.postID,
      'contact_name': instance.contactName,
      'contact_phone': instance.contactPhone,
      'payment_type': instance.payment,
      'specific_place': instance.specPlace,
      'note': instance.note,
      'order_status': instance.status,
      'price': instance.price,
      'is_cancel': instance.isCancel,
      'cancellation_reason': instance.cancelReason,
      'cancelled_by': instance.cancelBy,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
    };
