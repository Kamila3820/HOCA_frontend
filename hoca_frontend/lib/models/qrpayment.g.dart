// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'qrpayment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

QRpayment _$QRpaymentFromJson(Map<String, dynamic> json) => QRpayment(
      qrRawData: json['qrRawData'] as String?,
      qrImage: json['qrImage'] as String?,
      transactionId: json['transactionId'] as String?,
    );

Map<String, dynamic> _$QRpaymentToJson(QRpayment instance) => <String, dynamic>{
      'qrRawData': instance.qrRawData,
      'qrImage': instance.qrImage,
      'transactionId': instance.transactionId,
    };
