import 'package:json_annotation/json_annotation.dart';
part 'establishment.g.dart';

enum Price {
  @JsonValue('LOW')
  low("low"),
  @JsonValue('MEDIUM')
  medium("medium"),
  @JsonValue('HIGH')
  high("high");

  const Price(this.value);
  final String value;
  factory Price.fromString(String value) {
    return Price.values.firstWhere((enumValue) =>
    enumValue.value == value, orElse: () =>
    throw ArgumentError('Invalid price value: $value'));
  }
}

enum DayOfTheWeek {
  @JsonValue('MONDAY')
  monday("lundi"),
  @JsonValue('TUESDAY')
  tuesday("mardi"),
  @JsonValue('WEDNESDAY')
  wednesday("mercredi"),
  @JsonValue('THURSDAY')
  thursday("jeudi"),
  @JsonValue('FRIDAY')
  friday("vendredi"),
  @JsonValue('SATURDAY')
  saturday("samedi"),
  @JsonValue('SUNDAY')
  sunday("dimanche");

  const DayOfTheWeek(this.value);
  final String value;
  factory DayOfTheWeek.fromString(String value) {
    return DayOfTheWeek.values.firstWhere((enumValue) =>
    enumValue.value == value, orElse: () =>
    throw ArgumentError('Invalid price value: $value'));
  }

}

enum GameType {
  @JsonValue('POOL')
  pool('Billard'),

  @JsonValue('DARTS')
  darts('Fléchettes'),

  @JsonValue('BABYFOOT')
  babyfoot('Babyfoot'),

  @JsonValue('PINGPONG')
  pingpong('Ping-Pong'),

  @JsonValue('ARCADE')
  arcade('Arcade'),

  @JsonValue('PINBALL')
  pinball('Flipper'),

  @JsonValue('KARAOKE')
  karaoke('Karaoké'),

  @JsonValue('CARDS')
  cards('Cartes'),

  @JsonValue('BOARDGAME')
  boardgame('Sociétés'),

  @JsonValue('PETANQUE')
  petanque('Pétanque');
  const GameType(this.value);
  final String value;
  factory GameType.fromString(String value) {
    return GameType.values.firstWhere((enumValue) =>
    enumValue.value == value, orElse: () =>
    throw ArgumentError('Invalid price value: $value'));
  }
}

@JsonSerializable()
class GameTypeDto {
  @JsonKey(name: 'gameType')
  final GameType gameType;

  @JsonKey(name: 'numberOfGame')
  final int numberOfGame;

  GameTypeDto(this.gameType, this.numberOfGame);

  factory GameTypeDto.fromJson(Map<String, dynamic> json) =>
      _$GameTypeDtoFromJson(json);

  Map<String, dynamic> toJson() => _$GameTypeDtoToJson(this);
}

@JsonSerializable()
class DayOfTheWeekElemDto {
  @JsonKey(name: 'dayOfTheWeek')
  final DayOfTheWeek dayOfTheWeek;

  @JsonKey(name: 'openingTime')
  final String openingTime;  // LocalTime represented as String in format "HH:mm"

  @JsonKey(name: 'closingTime')
  final String closingTime;  // LocalTime represented as String in format "HH:mm"

  @JsonKey(name: 'isClosed')
  final bool isClosed;

  DayOfTheWeekElemDto(
      this.dayOfTheWeek,
      this.openingTime,
      this.closingTime,
      this.isClosed,
      );

  factory DayOfTheWeekElemDto.fromJson(Map<String, dynamic> json) =>
      _$DayOfTheWeekElemDtoFromJson(json);

  Map<String, dynamic> toJson() => _$DayOfTheWeekElemDtoToJson(this);
}

@JsonSerializable()
class Establishment {
  @JsonKey(name: 'id')
  final int? id;

  @JsonKey(name: 'name')
  final String name;

  @JsonKey(name: 'address')
  final String address;

  @JsonKey(name: 'site')
  final String site;

  @JsonKey(name: 'description')
  final String description;

  @JsonKey(name: 'proximityTransport')
  final bool proximityTransport;

  @JsonKey(name: 'accessPRM')
  final bool accessPRM;

  @JsonKey(name: 'price')
  final Price price;

  @JsonKey(name: 'emailAddress')
  final String emailAddress;

  @JsonKey(name: 'phoneNumber')
  final String phoneNumber;

  @JsonKey(name: 'longitude')
  final double longitude;

  @JsonKey(name: 'latitude')
  final double latitude;

  @JsonKey(name: 'dayScheduleList')
  final List<DayOfTheWeekElemDto> dayScheduleList;

  @JsonKey(name: 'gameTypeDtoList')
  final List<GameTypeDto> gameTypeDtoList;



  Establishment(
      this.id,
      this.name,
      this.address,
      this.site,
      this.description,
      this.proximityTransport,
      this.accessPRM,
      this.price,
      this.emailAddress,
      this.phoneNumber,
      this.longitude,
      this.latitude,
      this.dayScheduleList,
      this.gameTypeDtoList,
      );


  factory Establishment.fromJson(Map<String, dynamic> json) =>
      _$EstablishmentFromJson(json);


  Map<String, dynamic> toJson() => _$EstablishmentToJson(this);
}