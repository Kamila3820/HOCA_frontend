import 'package:json_annotation/json_annotation.dart';

part 'profile.g.dart';

@JsonSerializable()
class Profile {
  @JsonKey(name: 'id')
  final String userID;

  @JsonKey(name: 'user_name')
  final String? username;

  @JsonKey(name: 'email')
  final String? email;

  @JsonKey(name: 'avatar')
  final String? avatarUrl;

  @JsonKey(name: 'phone_number')
  final String? phonenumber;

  Profile(
      {
      required this.userID,
      required this.username,
      required this.email,
      required this.avatarUrl,
      required this.phonenumber,
      });

  factory Profile.fromJson(Map<String, dynamic> json) => _$ProfileFromJson(json);

  Map<String, dynamic> toJson() => _$ProfileToJson(this);
}