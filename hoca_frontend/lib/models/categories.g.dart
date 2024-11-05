// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'categories.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Categories _$CategoriesFromJson(Map<String, dynamic> json) => Categories(
      id: (json['id'] as num).toInt(),
      groupID: (json['group_id'] as num).toInt(),
      name: json['name'] as String,
      description: json['description'] as String,
    );

Map<String, dynamic> _$CategoriesToJson(Categories instance) =>
    <String, dynamic>{
      'id': instance.id,
      'group_id': instance.groupID,
      'name': instance.name,
      'description': instance.description,
    };
