// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'workerorder.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WorkerOrder _$WorkerOrderFromJson(Map<String, dynamic> json) => WorkerOrder(
      id: (json['id'] as num).toInt(),
      userID: json['user_id'] as String?,
      price: (json['price'] as num?)?.toDouble(),
      payment: json['payment_type'] as String?,
      postID: (json['worker_post_id'] as num?)?.toInt(),
      status: json['order_status'] as String?,
      contactName: json['contact_name'] as String?,
      contactPhone: json['contact_phone'] as String?,
      note: json['note'] as String?,
      specPlace: json['specific_place'] as String?,
    );

Map<String, dynamic> _$WorkerOrderToJson(WorkerOrder instance) =>
    <String, dynamic>{
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
    };
