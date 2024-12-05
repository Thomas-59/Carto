// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'address.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Address _$AddressFromJson(Map<String, dynamic> json) => Address(
      json['id'] as String?,
      Geometry.fromJson(json['geometry'] as Map<String, dynamic>),
      Properties.fromJson(json['properties'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$AddressToJson(Address instance) => <String, dynamic>{
      'id': instance.type,
      'geometry': instance.geometry,
      'properties': instance.properties,
    };

Properties _$PropertiesFromJson(Map<String, dynamic> json) => Properties(
      json['label'] as String,
      (json['score'] as num).toDouble(),
      json['housenumber'] as String?,
      json['id'] as String,
      json['banId'] as String?,
      json['name'] as String,
      json['postcode'] as String,
      json['citycode'] as String,
      (json['x'] as num).toDouble(),
      (json['y'] as num).toDouble(),
      json['city'] as String,
      json['context'] as String,
      json['type'] as String,
      (json['importance'] as num).toDouble(),
      json['street'] as String?,
    );

Map<String, dynamic> _$PropertiesToJson(Properties instance) =>
    <String, dynamic>{
      'label': instance.label,
      'score': instance.score,
      'housenumber': instance.housenumber,
      'id': instance.id,
      'banId': instance.banId,
      'name': instance.name,
      'postcode': instance.postcode,
      'citycode': instance.citycode,
      'x': instance.x,
      'y': instance.y,
      'city': instance.city,
      'context': instance.context,
      'type': instance.type,
      'importance': instance.importance,
      'street': instance.street,
    };

Geometry _$GeometryFromJson(Map<String, dynamic> json) => Geometry(
      json['type'] as String,
      (json['coordinates'] as List<dynamic>)
          .map((e) => (e as num).toDouble())
          .toList(),
    );

Map<String, dynamic> _$GeometryToJson(Geometry instance) => <String, dynamic>{
      'type': instance.type,
      'coordinates': instance.coordinates,
    };
