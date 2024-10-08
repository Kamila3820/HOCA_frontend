// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'history.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

History _$HistoryFromJson(Map<String, dynamic> json) => History(
      historyID: (json['historyID'] as num).toInt(),
      userID: json['userID'] as String,
      orderID: json['orderID'] as String,
      status: json['status'] as String,
      isRated: json['isRated'] as bool,
      cancellationReason: json['cancellationReason'] as String?,
      cancelledBy: json['cancelledBy'] as String?,
      name: json['name'] as String,
      price: (json['price'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$HistoryToJson(History instance) => <String, dynamic>{
      'historyID': instance.historyID,
      'userID': instance.userID,
      'orderID': instance.orderID,
      'status': instance.status,
      'isRated': instance.isRated,
      'cancellationReason': instance.cancellationReason,
      'cancelledBy': instance.cancelledBy,
      'name': instance.name,
      'price': instance.price,
    };
