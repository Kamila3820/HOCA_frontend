import 'package:json_annotation/json_annotation.dart';
import 'package:hoca_frontend/models/post.dart';

part 'posts.g.dart';

@JsonSerializable()
class Posts {
  @JsonKey(name: 'posts')
  final List<Post> posts;

  Posts({
    required this.posts,
  });
  factory Posts.fromJson(Map<String, dynamic> json) => _$PostsFromJson(json);

  Map<String, dynamic> toJson() => _$PostsToJson(this);
}