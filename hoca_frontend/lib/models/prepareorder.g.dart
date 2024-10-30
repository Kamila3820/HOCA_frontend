// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'prepareorder.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PrepareOrder _$PrepareOrderFromJson(Map<String, dynamic> json) => PrepareOrder(
      distance: (json['distance'] as List<dynamic>?)
          ?.map((e) => Route.fromJson(e as Map<String, dynamic>))
          .toList(),
      orderStatus: json['order_status'] as String,
      paymentType: json['payment_type'] as String,
      price: (json['price'] as num?)?.toDouble(),
      workerName: json['worker_name'] as String,
      workerPhone: json['worker_phone'] as String,
    );

Map<String, dynamic> _$PrepareOrderToJson(PrepareOrder instance) =>
    <String, dynamic>{
      'distance': instance.distance,
      'order_status': instance.orderStatus,
      'payment_type': instance.paymentType,
      'price': instance.price,
      'worker_name': instance.workerName,
      'worker_phone': instance.workerPhone,
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
