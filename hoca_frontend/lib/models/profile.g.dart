// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Profile _$ProfileFromJson(Map<String, dynamic> json) => Profile(
      userID: json['id'] as String,
      username: json['user_name'] as String?,
      email: json['email'] as String?,
      avatarUrl: json['avatar'] as String?,
      phonenumber: json['phone_number'] as String?,
    );

Map<String, dynamic> _$ProfileToJson(Profile instance) => <String, dynamic>{
      'id': instance.userID,
      'user_name': instance.username,
      'email': instance.email,
      'avatar': instance.avatarUrl,
      'phone_number': instance.phonenumber,
    };
