// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'placetype.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PlaceType _$PlaceTypeFromJson(Map<String, dynamic> json) => PlaceType(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      description: json['description'] as String,
    );

Map<String, dynamic> _$PlaceTypeToJson(PlaceType instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
    };
