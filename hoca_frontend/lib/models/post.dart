import 'package:hoca_frontend/models/placetype.dart';
import 'package:hoca_frontend/models/userrating.dart';
import 'package:json_annotation/json_annotation.dart';

part 'post.g.dart';

@JsonSerializable()
class Post {
  @JsonKey(name: 'id')
  final int postID;

  @JsonKey(name: 'owner_id')
  final String? ownerID;

  @JsonKey(name: 'name')
  final String? name;

  @JsonKey(name: 'description')
  final String? description;  // Nullable

  @JsonKey(name: 'avatar')
  final String? avatarUrl;

  @JsonKey(name: 'category_id')
  final int? categoryID;

  @JsonKey(name: 'location')
  final String? location;

  @JsonKey(name: 'latitude')
  final String? locationLat;

  @JsonKey(name: 'longtitude')
  final String? locationLong;

  @JsonKey(name: 'price')
  final double? price;

  @JsonKey(name: 'distance')
  final String? distance;  // Nullable

  @JsonKey(name: 'phone_number')
  final String? phoneNumber;

  @JsonKey(name: 'gender')
  final String? gender;

  @JsonKey(name: 'amount_family')
  final String? amountFamily;

  @JsonKey(name: 'total_score')
  final double? totalScore;  // Nullable

  @JsonKey(name: 'active_status')
  final bool? activeStatus;

  @JsonKey(name: 'place_types')
  final List<PlaceType>? placeTypeID;

  @JsonKey(name: 'user_ratings')
  final List<UserRating>? userRatings;  // Nullable List of UserRating

  Post({
    required this.postID,
    required this.ownerID,
    required this.name,
    this.description,  // Nullable
    required this.avatarUrl,
    required this.categoryID,
    required this.location,
    required this.locationLat,
    required this.locationLong,
    required this.price,
    this.distance,  // Nullable
    required this.phoneNumber,
    required this.gender,
    required this.amountFamily,
    this.totalScore,  // Nullable
    required this.activeStatus,
    required this.placeTypeID,  // Nullable
    this.userRatings,  // Nullable
  });

  factory Post.fromJson(Map<String, dynamic> json) => _$PostFromJson(json);

  Map<String, dynamic> toJson() => _$PostToJson(this);
}