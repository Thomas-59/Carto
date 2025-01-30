/// The enum who represent the role of the user
enum RoleEnum {
  /// A lambda user
  user("user"),
  /// A administrator of the application
  admin("admin"),
  /// A user who is a manager of one of the proposed establishment
  manager("manager");

  /// The initializer of the enum
  const RoleEnum(this.role);

  /// The type as String
  final String role;

  /// Give the type equivalent to the given value
  factory RoleEnum.fromString(String role) {
    return RoleEnum.values.firstWhere((enumRole) =>
    enumRole.role == role, orElse: () =>
    throw ArgumentError('Invalid role value: $role'));
  }
}