// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'address_search.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddressSearch _$AddressSearchFromJson(Map<String, dynamic> json) =>
    AddressSearch(
      json['type'] as String,
      json['version'] as String,
      (json['features'] as List<dynamic>)
          .map((e) => Address.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['attribution'] as String,
      json['licence'] as String,
      json['query'] as String,
      (json['limit'] as num).toInt(),
    );

Map<String, dynamic> _$AddressSearchToJson(AddressSearch instance) =>
    <String, dynamic>{
      'type': instance.type,
      'version': instance.version,
      'features': instance.addressList,
      'attribution': instance.attribution,
      'licence': instance.licence,
      'query': instance.query,
      'limit': instance.limit,
    };
