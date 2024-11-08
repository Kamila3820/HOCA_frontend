import 'package:hoca_frontend/models/categories.dart';
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

  @JsonKey(name: 'location')
  final String? location;

  @JsonKey(name: 'latitude')
  final String? locationLat;

  @JsonKey(name: 'longtitude')
  final String? locationLong;

  @JsonKey(name: 'price')
  final double? price;

  @JsonKey(name: 'prompt_pay')
  final String? promptPay;

  @JsonKey(name: 'distance')
  final String? distance; 

  @JsonKey(name: 'distance_fee')
  final String? distanceFee;  

  @JsonKey(name: 'phone_number')
  final String? phoneNumber;

  @JsonKey(name: 'gender')
  final String? gender;

  @JsonKey(name: 'amount_family')
  final String? amountFamily;

  @JsonKey(name: 'duration')
  final String? duration;

  @JsonKey(name: 'available_start')
  final String? availableStart;

  @JsonKey(name: 'available_end')
  final String? availableEnd;

  @JsonKey(name: 'total_score')
  final double? totalScore;  // Nullable

  @JsonKey(name: 'active_status')
  final bool? activeStatus;

  @JsonKey(name: 'categories')
  final List<Categories>? categoryID;

  @JsonKey(name: 'place_types')
  final List<PlaceType>? placeTypeID;

  @JsonKey(name: 'user_ratings')
  final List<UserRating>? userRatings;  // Nullable List of UserRating

  @JsonKey(name: 'created_at')
  final String? createdAt;

  @JsonKey(name: 'updated_at')
  final String? updatedAt;

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
    required this.promptPay,
    this.distance,  // Nullable
    this.distanceFee,
    required this.phoneNumber,
    required this.gender,
    required this.amountFamily,
    required this.duration,
    required this.availableStart,
    required this.availableEnd,
    this.totalScore,  // Nullable
    required this.activeStatus,
    required this.placeTypeID,  // Nullable
    required this.createdAt,
    required this.updatedAt,
    this.userRatings,  // Nullable
  });

  factory Post.fromJson(Map<String, dynamic> json) => _$PostFromJson(json);

  Map<String, dynamic> toJson() => _$PostToJson(this);
}