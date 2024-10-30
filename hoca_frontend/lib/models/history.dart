import 'package:json_annotation/json_annotation.dart';

part 'history.g.dart';

@JsonSerializable()
class History {
  @JsonKey(name: 'id')
  final int historyID;

  @JsonKey(name: 'user_id')
  final String? userID;

  @JsonKey(name: 'order_id')
  final String? orderID;

  @JsonKey(name: 'status')
  final String? status;

  @JsonKey(name: 'is_rated')
  final bool? isRated;

  @JsonKey(name: 'cancellation_reason')
  final String? cancellationReason;

  @JsonKey(name: 'cancelled_by')
  final String? cancelledBy;

  @JsonKey(name: 'name')
  final String? name;

  @JsonKey(name: 'price')
  final double? price;

  @JsonKey(name: 'created_at')
  final String? createdAt;


  History(
      {required this.historyID,
      required this.userID,
      required this.orderID,
      required this.status,
      required this.isRated,
      required this.cancellationReason,
      required this.cancelledBy,
      required this.name,
      required this.price,
      required this.createdAt
      });

  factory History.fromJson(Map<String, dynamic> json) => _$HistoryFromJson(json);

  Map<String, dynamic> toJson() => _$HistoryToJson(this);
}