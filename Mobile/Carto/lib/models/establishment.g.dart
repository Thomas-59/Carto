// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'establishment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GameTypeDto _$GameTypeDtoFromJson(Map<String, dynamic> json) => GameTypeDto(
      $enumDecode(_$GameTypeEnumMap, json['gameType']),
      (json['numberOfGame'] as num).toInt(),
    );

Map<String, dynamic> _$GameTypeDtoToJson(GameTypeDto instance) =>
    <String, dynamic>{
      'gameType': _$GameTypeEnumMap[instance.gameType]!,
      'numberOfGame': instance.numberOfGame,
    };

const _$GameTypeEnumMap = {
  GameType.pool: 'POOL',
  GameType.darts: 'DARTS',
  GameType.babyfoot: 'BABYFOOT',
  GameType.bowling: 'BOWLING',
  GameType.arcade: 'ARCADE',
  GameType.pinball: 'PINBALL',
  GameType.karaoke: 'KARAOKE',
  GameType.cards: 'CARDS',
  GameType.boardgame: 'BOARDGAME',
  GameType.petanque: 'PETANQUE',
};

DayOfTheWeekElemDto _$DayOfTheWeekElemDtoFromJson(Map<String, dynamic> json) =>
    DayOfTheWeekElemDto(
      $enumDecode(_$DayOfTheWeekEnumMap, json['dayOfTheWeek']),
      json['openingTime'] as String,
      json['closingTime'] as String,
      json['isClosed'] as bool,
    );

Map<String, dynamic> _$DayOfTheWeekElemDtoToJson(
        DayOfTheWeekElemDto instance) =>
    <String, dynamic>{
      'dayOfTheWeek': _$DayOfTheWeekEnumMap[instance.dayOfTheWeek]!,
      'openingTime': instance.openingTime,
      'closingTime': instance.closingTime,
      'isClosed': instance.isClosed,
    };

const _$DayOfTheWeekEnumMap = {
  DayOfTheWeek.monday: 'MONDAY',
  DayOfTheWeek.tuesday: 'TUESDAY',
  DayOfTheWeek.wednesday: 'WEDNESDAY',
  DayOfTheWeek.thursday: 'THURSDAY',
  DayOfTheWeek.friday: 'FRIDAY',
  DayOfTheWeek.saturday: 'SATURDAY',
  DayOfTheWeek.sunday: 'SUNDAY',
};

Establishment _$EstablishmentFromJson(Map<String, dynamic> json) =>
    Establishment(
      (json['id'] as num).toInt(),
      json['name'] as String,
      json['address'] as String,
      json['proximityTransport'] as bool,
      json['accessPRM'] as bool,
      $enumDecode(_$PriceEnumMap, json['price']),
      json['emailAddress'] as String,
      json['phoneNumber'] as String,
      (json['longitude'] as num).toDouble(),
      (json['latitude'] as num).toDouble(),
      (json['dayScheduleList'] as List<dynamic>)
          .map((e) => DayOfTheWeekElemDto.fromJson(e as Map<String, dynamic>))
          .toList(),
      (json['gameTypeDtoList'] as List<dynamic>)
          .map((e) => GameTypeDto.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$EstablishmentToJson(Establishment instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'address': instance.address,
      'proximityTransport': instance.proximityTransport,
      'accessPRM': instance.accessPRM,
      'price': _$PriceEnumMap[instance.price]!,
      'emailAddress': instance.emailAddress,
      'phoneNumber': instance.phoneNumber,
      'longitude': instance.longitude,
      'latitude': instance.latitude,
      'dayScheduleList': instance.dayScheduleList,
      'gameTypeDtoList': instance.gameTypeDtoList,
    };

const _$PriceEnumMap = {
  Price.low: 'LOW',
  Price.medium: 'MEDIUM',
  Price.high: 'HIGH',
};
