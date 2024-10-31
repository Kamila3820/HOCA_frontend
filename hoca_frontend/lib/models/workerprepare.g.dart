// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'workerprepare.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WorkerPrepare _$WorkerPrepareFromJson(Map<String, dynamic> json) =>
    WorkerPrepare(
      distance: (json['distance'] as List<dynamic>?)
          ?.map((e) => Route.fromJson(e as Map<String, dynamic>))
          .toList(),
      orderStatus: json['order_status'] as String?,
      paymentType: json['payment_type'] as String?,
      price: (json['price'] as num?)?.toDouble(),
      contactName: json['contact_name'] as String?,
      contactPhone: json['contact_phone'] as String?,
      userAvatar: json['user_avatar'] as String?,
      location: json['location'] as String?,
      note: json['note'] as String?,
      specPlace: json['specific_place'] as String?,
      createdAt: json['created_at'] as String?,
    );

Map<String, dynamic> _$WorkerPrepareToJson(WorkerPrepare instance) =>
    <String, dynamic>{
      'distance': instance.distance,
      'order_status': instance.orderStatus,
      'payment_type': instance.paymentType,
      'price': instance.price,
      'contact_name': instance.contactName,
      'contact_phone': instance.contactPhone,
      'user_avatar': instance.userAvatar,
      'location': instance.location,
      'specific_place': instance.specPlace,
      'note': instance.note,
      'created_at': instance.createdAt,
    };

Route _$RouteFromJson(Map<String, dynamic> json) => Route(
      summary: json['summary'] as String?,
      legs: (json['legs'] as List<dynamic>?)
          ?.map((e) => Leg.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$RouteToJson(Route instance) => <String, dynamic>{
      'summary': instance.summary,
      'legs': instance.legs,
    };

Leg _$LegFromJson(Map<String, dynamic> json) => Leg(
      distance: json['distance'] == null
          ? null
          : DistanceText.fromJson(json['distance'] as Map<String, dynamic>),
      duration: json['duration'] == null
          ? null
          : DurationText.fromJson(json['duration'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$LegToJson(Leg instance) => <String, dynamic>{
      'distance': instance.distance,
      'duration': instance.duration,
    };

DistanceText _$DistanceTextFromJson(Map<String, dynamic> json) => DistanceText(
      text: json['text'] as String?,
    );

Map<String, dynamic> _$DistanceTextToJson(DistanceText instance) =>
    <String, dynamic>{
      'text': instance.text,
    };

DurationText _$DurationTextFromJson(Map<String, dynamic> json) => DurationText(
      text: json['text'] as String?,
    );

Map<String, dynamic> _$DurationTextToJson(DurationText instance) =>
    <String, dynamic>{
      'text': instance.text,
    };
