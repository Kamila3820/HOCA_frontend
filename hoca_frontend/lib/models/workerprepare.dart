import 'package:json_annotation/json_annotation.dart';

part 'workerprepare.g.dart';

@JsonSerializable()
class WorkerPrepare {
  @JsonKey(name: 'distance')
  final List<Route>? distance; // Change this to Route

  @JsonKey(name: 'order_status')
  final String? orderStatus;

  @JsonKey(name: 'payment_type')
  final String? paymentType;

  @JsonKey(name: 'price')
  final double? price;

  @JsonKey(name: 'contact_name')
  final String? contactName;

  @JsonKey(name: 'contact_phone')
  final String? contactPhone;

  @JsonKey(name: 'user_avatar')
  final String? userAvatar;

  @JsonKey(name: 'location')
  final String? location;

  @JsonKey(name: 'specific_place')
  final String? specPlace;

  @JsonKey(name: 'note')
  final String? note;

  @JsonKey(name: 'duration')
  final String? duration;

  @JsonKey(name: 'created_at')
  final String? createdAt;

  WorkerPrepare({
    required this.distance,
    required this.orderStatus,
    required this.paymentType,
    required this.price,
    required this.contactName,
    required this.contactPhone,
    required this.userAvatar,
    required this.location,
    required this.note,
    required this.duration,
    required this.specPlace,
    required this.createdAt,
  });

  factory WorkerPrepare.fromJson(Map<String, dynamic> json) => _$WorkerPrepareFromJson(json);
  Map<String, dynamic> toJson() => _$WorkerPrepareToJson(this);
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
