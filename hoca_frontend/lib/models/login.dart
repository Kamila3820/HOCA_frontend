import 'package:json_annotation/json_annotation.dart';

part 'login.g.dart';

@JsonSerializable()
class Login {
  @JsonKey(name: 'token')
  final String token;

  Login({
    required this.token,
  });
  factory Login.fromJson(Map<String, dynamic> json) => _$LoginFromJson(json);

  Map<String, dynamic> toJson() => _$LoginToJson(this);
}