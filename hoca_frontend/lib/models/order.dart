import 'package:json_annotation/json_annotation.dart';

part 'order.g.dart';

@JsonSerializable()
class Order {
  @JsonKey(name: 'id')
  final int id;

  @JsonKey(name: 'user_id')
  final String? userID;

  @JsonKey(name: 'worker_post_id')
  final int? postID;

  @JsonKey(name: 'contact_name')
  final String? contactName;

  @JsonKey(name: 'contact_phone')
  final String? contactPhone;

  @JsonKey(name: 'payment_type')
  final String? payment;

  @JsonKey(name: 'specific_place')
  final String? specPlace;

  @JsonKey(name: 'note')
  final String? note;

  @JsonKey(name: 'order_status')
  final String? status;

  @JsonKey(name: 'price')
  final double? price;

  @JsonKey(name: 'is_cancel')
  final bool? isCancel;

  @JsonKey(name: 'cancellation_reason')
  final String? cancelReason;

  @JsonKey(name: 'cancelled_by')
  final String? cancelBy;

  @JsonKey(name: 'created_at')
  final String? createdAt;

  @JsonKey(name: 'updated_at')
  final String? updatedAt;

  Order({
    required this.id,
    required this.userID,
    required this.contactName,
    required this.contactPhone,
    required this.note,
    required this.specPlace,
    required this.price,
    required this.payment,
    required this.postID,
    required this.status,
    required this.isCancel,
    required this.cancelReason,
    required this.cancelBy,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Order.fromJson(Map<String, dynamic> json) => _$OrderFromJson(json);

  Map<String, dynamic> toJson() => _$OrderToJson(this);
}
