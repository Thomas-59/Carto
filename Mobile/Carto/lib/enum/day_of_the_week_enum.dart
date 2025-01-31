/// The enum who represent the day in the week
enum DayOfTheWeekEnum {
  /// The monday type
  monday("lundi"),
  /// The tuesday type
  tuesday("mardi"),
  /// The wednesday type
  wednesday("mercredi"),
  /// The thursday type
  thursday("jeudi"),
  /// The friday type
  friday("vendredi"),
  /// The saturday type
  saturday("samedi"),
  /// The sunday type
  sunday("dimanche");

  /// The initializer of the enum
  const DayOfTheWeekEnum(this.value);

  /// The type as String
  final String value;
}