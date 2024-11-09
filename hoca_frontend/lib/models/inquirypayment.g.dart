// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'inquirypayment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

InquiryPayment _$InquiryPaymentFromJson(Map<String, dynamic> json) =>
    InquiryPayment(
      paymentSuccess: json['paymentSuccess'] as bool?,
      message: json['message'] as String?,
    );

Map<String, dynamic> _$InquiryPaymentToJson(InquiryPayment instance) =>
    <String, dynamic>{
      'paymentSuccess': instance.paymentSuccess,
      'message': instance.message,
    };
