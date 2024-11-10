enum PriceEnum {
  low("low"),
  medium("medium"),
  high("high");

  const PriceEnum(this.value);
  final String value;

  factory PriceEnum.fromString(String value) {
    return PriceEnum.values.firstWhere((enumValue) =>
      enumValue.value == value, orElse: () =>
      throw ArgumentError('Invalid price value: $value'));
  }
}