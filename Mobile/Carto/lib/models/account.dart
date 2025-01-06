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

  @JsonKey(name: 'managerInformation')
  final ManagerInformation? managerInformation;

  Account({
    this.id,
    required this.username,
    required this.emailAddress,
    required this.password,
    required this.createdAt,
    required this.role,
    this.managerInformation,
  });

  // Factory constructor for a default account
  factory Account.defaultAccount() {
    return Account(
      id: null,
      username: '',
      emailAddress: '',
      password: '',
      createdAt: DateTime.now(),
      role: Role.user,
      managerInformation: null,
    );
  }

  factory Account.fromJson(Map<String, dynamic> json) =>
      _$AccountFromJson(json);

  Map<String, dynamic> toJson() => _$AccountToJson(this);
}

@JsonSerializable()
class ManagerInformation {
  String surname;
  String firstname;
  String phoneNumber;
  String sirenNumber;

  ManagerInformation({
    required this.surname,
    required this.firstname,
    required this.phoneNumber,
    required this.sirenNumber,
  });

  factory ManagerInformation.fromJson(Map<String, dynamic> json) =>
      _$ManagerInformationFromJson(json);

  Map<String, dynamic> toJson() => _$ManagerInformationToJson(this);
}

enum Role {
  @JsonValue('USER')
  user,
  @JsonValue('ADMIN')
  admin,
  @JsonValue('MANAGER')
  manager
}
