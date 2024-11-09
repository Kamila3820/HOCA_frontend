// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'workerfee.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WorkerFee _$WorkerFeeFromJson(Map<String, dynamic> json) => WorkerFee(
      qrRawData: json['qrRawData'] as String?,
      qrImage: json['qrImage'] as String?,
      transactionId: json['transactionId'] as String?,
      amount: (json['amount'] as num?)?.toInt(),
      orderCount: (json['order_count'] as num?)?.toInt(),
      startFrom: json['start_from'] as String?,
      endFrom: json['end_from'] as String?,
      endedAt: json['ended_at'] as String?,
    );

Map<String, dynamic> _$WorkerFeeToJson(WorkerFee instance) => <String, dynamic>{
      'qrRawData': instance.qrRawData,
      'qrImage': instance.qrImage,
      'transactionId': instance.transactionId,
      'order_count': instance.orderCount,
      'amount': instance.amount,
      'start_from': instance.startFrom,
      'end_from': instance.endFrom,
      'ended_at': instance.endedAt,
    };
