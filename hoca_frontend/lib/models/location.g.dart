// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'location.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Location _$LocationFromJson(Map<String, dynamic> json) => Location(
      location: json['location'] as String?,
      latitude: json['latitude'] as String?,
      longtitude: json['longtitude'] as String?,
    );

Map<String, dynamic> _$LocationToJson(Location instance) => <String, dynamic>{
      'location': instance.location,
      'latitude': instance.latitude,
      'longtitude': instance.longtitude,
    };
