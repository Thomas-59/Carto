import 'package:json_annotation/json_annotation.dart';

part 'account.g.dart';

@JsonSerializable()
class Account {
  @JsonKey(name: 'id')
  final int? id;

  @JsonKey(name: 'username')
  final String username;

  @JsonKey(name: 'emailAddress')
  final String emailAddress;

  @JsonKey(name: 'password')
  final String password;

  @JsonKey(name: 'createdAt')
  final DateTime createdAt;

  @JsonKey(name: 'role')
  final Role role;

  Account({
    this.id,
    required this.username,
    required this.emailAddress,
    required this.password,
    required this.createdAt,
    required this.role,
  });

  factory Account.fromJson(Map<String, dynamic> json) => _$AccountFromJson(json);

  Map<String, dynamic> toJson() => _$AccountToJson(this);
}

enum Role {
  @JsonValue('USER')
  user,
  @JsonValue('ADMIN')
  admin,
  @JsonValue('MANAGER')
  manager
}
