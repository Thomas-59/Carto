import 'package:json_annotation/json_annotation.dart';
part 'establishment.g.dart';

/// The enum who represent the average price of a game in the establishment in the data base
enum Price {
  /// The average price of a game is lower than average
  @JsonValue('LOW')
  low("low"),
  /// The average price of a game is in the average
  @JsonValue('MEDIUM')
  medium("medium"),
  /// The average price of a game is upper than average
  @JsonValue('HIGH')
  high("high");

  /// The initializer of the enum
  const Price(this.value);

  /// The type as String
  final String value;

  /// Give the type equivalent to the given value
  factory Price.fromString(String value) {
    return Price.values.firstWhere((enumValue) =>
    enumValue.value == value, orElse: () =>
    throw ArgumentError('Invalid price value: $value'));
  }
}

/// A enum who represent the day of the week
enum DayOfTheWeek {
  /// The monday type
  @JsonValue('MONDAY')
  monday("lundi"),
  /// The tuesday type
  @JsonValue('TUESDAY')
  tuesday("mardi"),
  /// The wednesday type
  @JsonValue('WEDNESDAY')
  wednesday("mercredi"),
  /// The thursday type
  @JsonValue('THURSDAY')
  thursday("jeudi"),
  /// The friday type
  @JsonValue('FRIDAY')
  friday("vendredi"),
  /// The saturday type
  @JsonValue('SATURDAY')
  saturday("samedi"),
  /// The sunday type
  @JsonValue('SUNDAY')
  sunday("dimanche");

  /// The initializer of the enum
  const DayOfTheWeek(this.value);

  /// The day of the week in french
  final String value;

  /// Give the type equivalent to the given value
  factory DayOfTheWeek.fromString(String value) {
    return DayOfTheWeek.values.firstWhere((enumValue) =>
    enumValue.value == value, orElse: () =>
    throw ArgumentError('Invalid price value: $value'));
  }

}

/// The enum who represent the game available in the database
enum GameType {
  /// The pool game
  @JsonValue('POOL')
  pool('Billard'),

  /// The dart game
  @JsonValue('DARTS')
  darts('Fléchettes'),

  /// The baby foot game
  @JsonValue('BABYFOOT')
  babyfoot('Babyfoot'),

  /// The ping pong game
  @JsonValue('PINGPONG')
  pingpong('Ping-Pong'),

  /// The arcade game
  @JsonValue('ARCADE')
  arcade('Arcade'),

  /// The pinball game
  @JsonValue('PINBALL')
  pinball('Flipper'),

  /// A karaoke room
  @JsonValue('KARAOKE')
  karaoke('Karaoké'),

  /// A cards game
  @JsonValue('CARDS')
  cards('Cartes'),

  /// A board game
  @JsonValue('BOARDGAME')
  boardgame('Sociétés'),

  /// A petanque game
  @JsonValue('PETANQUE')
  petanque('Pétanque');

  /// The initializer of the enum
  const GameType(this.value);

  /// The type as String
  final String value;

  /// Give the type equivalent to the given value
  factory GameType.fromString(String value) {
    return GameType.values.firstWhere((enumValue) =>
    enumValue.value == value, orElse: () =>
    throw ArgumentError('Invalid price value: $value'));
  }
}

/// A class who represent the type of game and their number
@JsonSerializable()
class GameTypeDto {
  /// The type of the game
  @JsonKey(name: 'gameType')
  final GameType gameType;

  ///The number of game
  @JsonKey(name: 'numberOfGame')
  final int numberOfGame;

  /// The initializer of the class
  GameTypeDto(this.gameType, this.numberOfGame);

  /// A factory to get a GameType from json
  factory GameTypeDto.fromJson(Map<String, dynamic> json) =>
      _$GameTypeDtoFromJson(json);

  /// Parse a GameType to json
  Map<String, dynamic> toJson() => _$GameTypeDtoToJson(this);
}

/// A class who represent the opening of a establishment in a day
@JsonSerializable()
class DayOfTheWeekElemDto {
  /// The day of the week
  @JsonKey(name: 'dayOfTheWeek')
  final DayOfTheWeek dayOfTheWeek;

  /// The hour when the establishment open is door
  @JsonKey(name: 'openingTime')
  final String openingTime;  // LocalTime represented as String in format "HH:mm"

  /// The hour when the establishment close is door
  @JsonKey(name: 'closingTime')
  final String closingTime;  // LocalTime represented as String in format "HH:mm"

  /// A boolean to show if the establishment is open
  @JsonKey(name: 'isClosed')
  final bool isClosed;

  /// The initializer of the class
  DayOfTheWeekElemDto(
    this.dayOfTheWeek,
    this.openingTime,
    this.closingTime,
    this.isClosed,
  );

  /// A factory to get a DayOfTheWeekElemDto from json
  factory DayOfTheWeekElemDto.fromJson(Map<String, dynamic> json) =>
      _$DayOfTheWeekElemDtoFromJson(json);

  /// Parse a DayOfTheWeekElemDto to json
  Map<String, dynamic> toJson() => _$DayOfTheWeekElemDtoToJson(this);
}

/// A class who represent a establishment in the data base
@JsonSerializable()
class Establishment {
  ///The id of the establishment in the data base
  @JsonKey(name: 'id')
  final int? id;

  /// The name of the establishment
  @JsonKey(name: 'name')
  final String name;

  /// the address of the establishment
  @JsonKey(name: 'address')
  final String address;

  /// The web site of the establishment
  @JsonKey(name: 'site')
  final String site;

  /// The description of the establishment
  @JsonKey(name: 'description')
  final String description;

  /// If the establishment is near common transport
  @JsonKey(name: 'proximityTransport')
  final bool proximityTransport;

  /// If the establishment have PMR access
  @JsonKey(name: 'accessPRM')
  final bool accessPRM;

  /// The average price of a game in the establishment
  @JsonKey(name: 'price')
  final Price price;

  /// The email address of the establishment
  @JsonKey(name: 'emailAddress')
  final String emailAddress;

  /// The phone number of the establishment
  @JsonKey(name: 'phoneNumber')
  final String phoneNumber;

  /// The longitude in the coordinate of the establishment
  @JsonKey(name: 'longitude')
  final double longitude;

  /// The latitude in the coordinate of the establishment
  @JsonKey(name: 'latitude')
  final double latitude;

  /// The schedule of opening of the establishment
  @JsonKey(name: 'dayScheduleList')
  final List<DayOfTheWeekElemDto> dayScheduleList;

  /// The list of games available in the establishment
  @JsonKey(name: 'gameTypeDtoList')
  final List<GameTypeDto> gameTypeDtoList;

  /// The initializer of the class
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

  /// A factory to get a Establishment from json
  factory Establishment.fromJson(Map<String, dynamic> json) =>
      _$EstablishmentFromJson(json);

  /// Parse a Establishment to json
  Map<String, dynamic> toJson() => _$EstablishmentToJson(this);
}