import 'package:json_annotation/json_annotation.dart';

part 'userorder.g.dart';

@JsonSerializable()
class UserOrder {
  @JsonKey(name: 'id')
  final int id;

  @JsonKey(name: 'user_id')
  final String? userID;

  @JsonKey(name: 'worker_post_id')
  final int? postID;

  @JsonKey(name: 'worker_name')
  final String? workerName;

  @JsonKey(name: 'worker_phone')
  final String? workerPhone;

  @JsonKey(name: 'worker_avatar')
  final String? workerAvatar;

  @JsonKey(name: 'payment_type')
  final String? payment;

  @JsonKey(name: 'order_status')
  final String? status;

  @JsonKey(name: 'price')
  final double? price;

  @JsonKey(name: 'paid')
  final bool? paid;

  UserOrder({
    required this.id,
    required this.userID,
    required this.price,
    required this.paid,
    required this.payment,
    required this.postID,
    required this.status,
    required this.workerName,
    required this.workerPhone,
    required this.workerAvatar,
  });

  factory UserOrder.fromJson(Map<String, dynamic> json) => _$UserOrderFromJson(json);

  Map<String, dynamic> toJson() => _$UserOrderToJson(this);
}
