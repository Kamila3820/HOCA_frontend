import 'package:json_annotation/json_annotation.dart';

part 'history.g.dart';

@JsonSerializable()
class History {
  @JsonKey(name: 'historyID')
  final int historyID;

  @JsonKey(name: 'userID')
  final String userID;

  @JsonKey(name: 'orderID')
  final String orderID;

  @JsonKey(name: 'status')
  final String status;

  @JsonKey(name: 'isRated')
  final bool isRated;

  @JsonKey(name: 'cancellationReason')
  final String? cancellationReason;

  @JsonKey(name: 'cancelledBy')
  final String? cancelledBy;

  @JsonKey(name: 'name')
  final String name;

  @JsonKey(name: 'price')
  final double? price;


  History(
      {required this.historyID,
      required this.userID,
      required this.orderID,
      required this.status,
      required this.isRated,
      required this.cancellationReason,
      required this.cancelledBy,
      required this.name,
      required this.price
      });

  factory History.fromJson(Map<String, dynamic> json) => _$HistoryFromJson(json);

  Map<String, dynamic> toJson() => _$HistoryToJson(this);
}