enum RoleEnum {
  user("user"),
  admin("admin"),
  manager("manager");

  const RoleEnum(this.role);
  final String role;

  factory RoleEnum.fromString(String role) {
    return RoleEnum.values.firstWhere((enumRole) =>
    enumRole.role == role, orElse: () =>
    throw ArgumentError('Invalid role value: $role'));
  }
}