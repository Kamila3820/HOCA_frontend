// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'homepost.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HomePost _$HomePostFromJson(Map<String, dynamic> json) => HomePost(
      posts: (json['posts'] as List<dynamic>)
          .map((e) => Post.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$HomePostToJson(HomePost instance) => <String, dynamic>{
      'posts': instance.posts,
    };
