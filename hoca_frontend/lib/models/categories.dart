import 'package:json_annotation/json_annotation.dart';

part 'categories.g.dart';

@JsonSerializable()
class Categories {
  @JsonKey(name: 'id')
  final int id;

  @JsonKey(name: 'group_id')
  final int groupID;

  @JsonKey(name: 'name')
  final String name;

  @JsonKey(name: 'description')
  final String description;

  Categories({
    required this.id,
    required this.groupID,
    required this.name,
    required this.description,
  });

  factory Categories.fromJson(Map<String, dynamic> json) => _$CategoriesFromJson(json);

  Map<String, dynamic> toJson() => _$CategoriesToJson(this);
}
