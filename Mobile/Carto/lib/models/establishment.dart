import 'package:json_annotation/json_annotation.dart';
part 'establishment.g.dart';

@JsonSerializable()
class Establishment {
  @JsonKey(name: 'id')
  final int id;
  @JsonKey(name: 'name')
  final String name;
  @JsonKey(name: 'cityName')
  final String cityName;
  @JsonKey(name: 'latitude')
  final double latitude;
  @JsonKey(name: 'longitude')
  final double longitude;
  @JsonKey(name: 'description')
  final String description;


  Establishment(this.id, this.name, this.cityName, this.latitude,
      this.longitude, this.description);

  factory Establishment.fromJson(Map<String, dynamic> json) =>
      _$EstablishmentFromJson(json);

  Map<String, dynamic> toJson() => _$EstablishmentToJson(this);
}