import 'package:json_annotation/json_annotation.dart';

part 'workerorder.g.dart';

@JsonSerializable()
class WorkerOrder {
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

  @JsonKey(name: 'user_avatar')
  final String? userAvatar;

  @JsonKey(name: 'payment_type')
  final String? payment;

  @JsonKey(name: 'specific_place')
  final String? specPlace;

  @JsonKey(name: 'location')
  final String? location;

  @JsonKey(name: 'note')
  final String? note;

  @JsonKey(name: 'order_status')
  final String? status;

  @JsonKey(name: 'price')
  final double? price;

  @JsonKey(name: 'created_at')
  final String? createdAt;

  @JsonKey(name: 'ended_at')
  final String? endedAt;

  WorkerOrder({
    required this.id,
    required this.userID,
    required this.price,
    required this.payment,
    required this.postID,
    required this.status,
    required this.contactName,
    required this.contactPhone,
    required this.userAvatar,
    required this.note,
    required this.specPlace,
    required this.location,
    required this.createdAt,
    required this.endedAt
  });

  factory WorkerOrder.fromJson(Map<String, dynamic> json) => _$WorkerOrderFromJson(json);

  Map<String, dynamic> toJson() => _$WorkerOrderToJson(this);
}
