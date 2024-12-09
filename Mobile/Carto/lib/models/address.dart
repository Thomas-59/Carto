
import 'package:json_annotation/json_annotation.dart';
part 'address.g.dart';
@JsonSerializable()
class Address{
  @JsonKey(name:"id")
  final String? type;
  @JsonKey(name:"geometry")
  final Geometry geometry;
  @JsonKey(name:"properties")
  final Properties properties;

  Address(this.type, this.geometry, this.properties);

  factory Address.fromJson(Map<String, dynamic> json) =>
      _$AddressFromJson(json);

  Map<String, dynamic> toJson() => _$AddressToJson(this);
}

@JsonSerializable()
class Properties {
  @JsonKey(name: 'label')
  final String label;
  @JsonKey(name: 'score')
  final double score;
  @JsonKey(name: 'housenumber')
  final String? housenumber;
  @JsonKey(name: 'id')
  final String id;
  @JsonKey(name: 'banId')
  final String? banId;
  @JsonKey(name: 'name')
  final String name;
  @JsonKey(name: 'postcode')
  final String postcode;
  @JsonKey(name: 'citycode')
  final String citycode;
  @JsonKey(name: 'x')
  final double x;
  @JsonKey(name: 'y')
  final double y;
  @JsonKey(name: 'city')
  final String city;
  @JsonKey(name: 'context')
  final String context;
  @JsonKey(name: 'type')
  final String type;
  @JsonKey(name: 'importance')
  final double importance;
  @JsonKey(name: 'street')
  final String? street;

  Properties(
      this.label,
      this.score,
      this.housenumber,
      this.id,
      this.banId,
      this.name,
      this.postcode,
      this.citycode,
      this.x,
      this.y,
      this.city,
      this.context,
      this.type,
      this.importance,
      this.street);

  factory Properties.fromJson(Map<String, dynamic> json) =>
      _$PropertiesFromJson(json);

  Map<String, dynamic> toJson() => _$PropertiesToJson(this);
}
@JsonSerializable()
class Geometry {
  @JsonKey(name: "type")
  final String type;
  @JsonKey(name: "coordinates")
  final List<double> coordinates;

  Geometry(this.type, this.coordinates);

  factory Geometry.fromJson(Map<String, dynamic> json) =>
      _$GeometryFromJson(json);

  Map<String, dynamic> toJson() => _$GeometryToJson(this);
}