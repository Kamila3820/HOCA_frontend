import 'package:json_annotation/json_annotation.dart';

part 'workerfee.g.dart';

@JsonSerializable()
class WorkerFee {
  @JsonKey(name: 'qrRawData')
  final String? qrRawData;

  @JsonKey(name: 'qrImage')
  final String? qrImage;

  @JsonKey(name: 'transactionId')
  final String? transactionId;

  @JsonKey(name: 'order_count')
  final int? orderCount;

  @JsonKey(name: 'amount')
  final int? amount;

  @JsonKey(name: 'start_from')
  final String? startFrom;

  @JsonKey(name: 'end_from')
  final String? endFrom;

  @JsonKey(name: 'ended_at')
  final String? endedAt;

  WorkerFee(
      {required this.qrRawData,
      required this.qrImage,
      required this.transactionId,
      required this.amount,
      required this.orderCount,
      required this.startFrom,
      required this.endFrom,
      required this.endedAt,
      });

  factory WorkerFee.fromJson(Map<String, dynamic> json) => _$WorkerFeeFromJson(json);

  Map<String, dynamic> toJson() => _$WorkerFeeToJson(this);
}