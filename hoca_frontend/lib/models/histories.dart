import 'package:json_annotation/json_annotation.dart';
import 'package:hoca_frontend/models/history.dart';

part 'histories.g.dart';

@JsonSerializable()
class Histories {
  @JsonKey(name: 'posts')
  final List<History> histories;

  Histories({
    required this.histories,
  });
  factory Histories.fromJson(Map<String, dynamic> json) => _$HistoriesFromJson(json);

  Map<String, dynamic> toJson() => _$HistoriesToJson(this);
}