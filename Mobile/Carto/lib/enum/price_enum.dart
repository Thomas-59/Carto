/// The enum who represent the average price of a game in the establishment
enum PriceEnum {
  /// The average price of a game is lower than average
  low("low"),
  /// The average price of a game is in the average
  medium("medium"),
  /// The average price of a game is upper than average
  high("high");

  /// The initializer of the enum
  const PriceEnum(this.value);

  /// The type as String
  final String value;

  /// Give the type equivalent to the given value
  factory PriceEnum.fromString(String value) {
    return PriceEnum.values.firstWhere((enumValue) =>
      enumValue.value == value, orElse: () =>
      throw ArgumentError('Invalid price value: $value'));
  }
}