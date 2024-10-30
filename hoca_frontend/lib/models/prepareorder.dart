import 'package:json_annotation/json_annotation.dart';

part 'prepareorder.g.dart';

@JsonSerializable()
class PrepareOrder {
  @JsonKey(name: 'distance')
  final List<Route>? distance; // Change this to Route

  @JsonKey(name: 'order_status')
  final String orderStatus;

  @JsonKey(name: 'payment_type')
  final String paymentType;

  @JsonKey(name: 'price')
  final double? price;

  @JsonKey(name: 'worker_name')
  final String workerName;

  @JsonKey(name: 'worker_phone')
  final String workerPhone;

  @JsonKey(name: 'worker_avatar')
  final String? workerAvatar;

  PrepareOrder({
    required this.distance,
    required this.orderStatus,
    required this.paymentType,
    required this.price,
    required this.workerName,
    required this.workerPhone,
    required this.workerAvatar,
  });

  factory PrepareOrder.fromJson(Map<String, dynamic> json) => _$PrepareOrderFromJson(json);
  Map<String, dynamic> toJson() => _$PrepareOrderToJson(this);
}

@JsonSerializable()
class Route {
  @JsonKey(name: 'summary')
  final String? summary;

  @JsonKey(name: 'legs')
  final List<Leg>? legs;

  Route({
    required this.summary,
    required this.legs,
  });

  factory Route.fromJson(Map<String, dynamic> json) => _$RouteFromJson(json);
  Map<String, dynamic> toJson() => _$RouteToJson(this);
}

@JsonSerializable()
class Leg {
  @JsonKey(name: 'distance')
  final DistanceText? distance;

  @JsonKey(name: 'duration')
  final DurationText? duration;

  Leg({
    required this.distance,
    required this.duration,
  });

  factory Leg.fromJson(Map<String, dynamic> json) => _$LegFromJson(json);
  Map<String, dynamic> toJson() => _$LegToJson(this);
}

@JsonSerializable()
class DistanceText {
  @JsonKey(name: 'text')
  final String? text;

  DistanceText({
    required this.text,
  });

  factory DistanceText.fromJson(Map<String, dynamic> json) => _$DistanceTextFromJson(json);
  Map<String, dynamic> toJson() => _$DistanceTextToJson(this);
}

@JsonSerializable()
class DurationText {
  @JsonKey(name: 'text')
  final String? text;

  DurationText({
    required this.text,
  });

  factory DurationText.fromJson(Map<String, dynamic> json) => _$DurationTextFromJson(json);
  Map<String, dynamic> toJson() => _$DurationTextToJson(this);
}
