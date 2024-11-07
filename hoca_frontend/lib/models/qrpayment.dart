import 'package:json_annotation/json_annotation.dart';

part 'qrpayment.g.dart';

@JsonSerializable()
class QRpayment {
  @JsonKey(name: 'qrRawData')
  final String? qrRawData;

  @JsonKey(name: 'qrImage')
  final String? qrImage;

  @JsonKey(name: 'transactionId')
  final String? transactionId;

  QRpayment(
      {required this.qrRawData,
      required this.qrImage,
      required this.transactionId,
      });

  factory QRpayment.fromJson(Map<String, dynamic> json) => _$QRpaymentFromJson(json);

  Map<String, dynamic> toJson() => _$QRpaymentToJson(this);
}