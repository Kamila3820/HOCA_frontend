// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Post _$PostFromJson(Map<String, dynamic> json) => Post(
      postID: (json['id'] as num).toInt(),
      ownerID: json['owner_id'] as String?,
      name: json['name'] as String?,
      description: json['description'] as String?,
      avatarUrl: json['avatar'] as String?,
      categoryID: (json['category_id'] as num?)?.toInt(),
      location: json['location'] as String?,
      locationLat: json['latitude'] as String?,
      locationLong: json['longtitude'] as String?,
      price: (json['price'] as num?)?.toDouble(),
      promptPay: json['prompt_pay'] as String?,
      distance: json['distance'] as String?,
      phoneNumber: json['phone_number'] as String?,
      gender: json['gender'] as String?,
      amountFamily: json['amount_family'] as String?,
      totalScore: (json['total_score'] as num?)?.toDouble(),
      activeStatus: json['active_status'] as bool?,
      placeTypeID: (json['place_types'] as List<dynamic>?)
          ?.map((e) => PlaceType.fromJson(e as Map<String, dynamic>))
          .toList(),
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
      userRatings: (json['user_ratings'] as List<dynamic>?)
          ?.map((e) => UserRating.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$PostToJson(Post instance) => <String, dynamic>{
      'id': instance.postID,
      'owner_id': instance.ownerID,
      'name': instance.name,
      'description': instance.description,
      'avatar': instance.avatarUrl,
      'category_id': instance.categoryID,
      'location': instance.location,
      'latitude': instance.locationLat,
      'longtitude': instance.locationLong,
      'price': instance.price,
      'prompt_pay': instance.promptPay,
      'distance': instance.distance,
      'phone_number': instance.phoneNumber,
      'gender': instance.gender,
      'amount_family': instance.amountFamily,
      'total_score': instance.totalScore,
      'active_status': instance.activeStatus,
      'place_types': instance.placeTypeID,
      'user_ratings': instance.userRatings,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
    };
