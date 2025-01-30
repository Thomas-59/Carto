/// The enum who represent the type of a game in the establishment
enum GameTypeEnum {
  /// The pool game
  pool('Billard'),
  /// The dart game
  darts('Fléchettes'),
  /// The baby foot game
  babyfoot('Babyfoot'),
  /// The ping pong game
  pingpong('Ping-Pong'),
  /// The arcade game
  arcade('Arcade'),
  /// The pinball game
  pinball('Flipper'),
  /// A karaoke room
  karaoke('Karaoké'),
  /// A cards game
  cards('Cartes'),
  /// A board game
  boardgame('Sociétés'),
  /// A petanque game
  petanque('Pétanque');

  /// The initializer of the enum
  const GameTypeEnum(this.value);

  /// The type as String
  final String value;
}