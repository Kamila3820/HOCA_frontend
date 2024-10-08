import 'package:json_annotation/json_annotation.dart';

part 'placetype.g.dart';

@JsonSerializable()
class PlaceType {
  @JsonKey(name: 'id')
  final int id;

  @JsonKey(name: 'name')
  final String name;

  @JsonKey(name: 'description')
  final String description;

  PlaceType({
    required this.id,
    required this.name,
    required this.description,
  });

  factory PlaceType.fromJson(Map<String, dynamic> json) => _$PlaceTypeFromJson(json);

  Map<String, dynamic> toJson() => _$PlaceTypeToJson(this);
}
