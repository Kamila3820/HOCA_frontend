import 'package:json_annotation/json_annotation.dart';

part 'location.g.dart';

@JsonSerializable()
class Location {
  @JsonKey(name: 'location')
  final String? location;

  @JsonKey(name: 'latitude')
  final String? latitude;

  @JsonKey(name: 'longtitude')
  final String? longtitude;

  Location({
    required this.location,
    required this.latitude,
    required this.longtitude,
  });
  factory Location.fromJson(Map<String, dynamic> json) => _$LocationFromJson(json);

  Map<String, dynamic> toJson() => _$LocationToJson(this);
}