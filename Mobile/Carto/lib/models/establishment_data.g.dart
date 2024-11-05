// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'establishment_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EstablishmentData _$EstablishmentDataFromJson(Map<String, dynamic> json) =>
    EstablishmentData(
      (json['establishmentList'] as List<dynamic>)
          .map((e) => Establishment.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$EstablishmentDataToJson(EstablishmentData instance) =>
    <String, dynamic>{
      'establishmentList': instance.establishmentList,
    };
