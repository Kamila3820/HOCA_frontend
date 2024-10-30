import 'package:json_annotation/json_annotation.dart';

part 'notificationorder.g.dart';

@JsonSerializable()
class NotificationOrder {

  @JsonKey(name: 'order_id')
  final int? orderID;

  NotificationOrder({
    required this.orderID,
  });

  factory NotificationOrder.fromJson(Map<String, dynamic> json) =>
      _$NotificationOrderFromJson(json);

  Map<String, dynamic> toJson() => _$NotificationOrderToJson(this);
}