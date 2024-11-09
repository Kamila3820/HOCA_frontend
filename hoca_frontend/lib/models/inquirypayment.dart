import 'package:json_annotation/json_annotation.dart';

part 'inquirypayment.g.dart';

@JsonSerializable()
class InquiryPayment {
  @JsonKey(name: 'paymentSuccess')
  final bool? paymentSuccess;

  @JsonKey(name: 'message')
  final String? message;

  InquiryPayment(
      {required this.paymentSuccess,
      required this.message,
      });

  factory InquiryPayment.fromJson(Map<String, dynamic> json) => _$InquiryPaymentFromJson(json);

  Map<String, dynamic> toJson() => _$InquiryPaymentToJson(this);
}