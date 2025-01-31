import 'package:json_annotation/json_annotation.dart';

part 'account.g.dart';

/// A class who represent the user data in the database
@JsonSerializable()
class Account {
  /// The id of the account in the database
  @JsonKey(name: 'id')
  final int? id;

  /// The name of the account
  @JsonKey(name: 'username')
  final String username;

  /// The email linked to the account
  @JsonKey(name: 'emailAddress')
  final String emailAddress;

  /// The password of the account
  @JsonKey(name: 'password')
  final String password;

  /// The date when the account was created
  @JsonKey(name: 'createdAt')
  final DateTime createdAt;

  /// The role possessed by the account
  @JsonKey(name: 'role')
  final Role role;

  /// The data related to the manager part of the account
  @JsonKey(name: 'managerInformation')
  final ManagerInformation? managerInformation;

  /// The initializer of the class
  Account({
    this.id,
    required this.username,
    required this.emailAddress,
    required this.password,
    required this.createdAt,
    required this.role,
    this.managerInformation,
  });

  /// Factory constructor for a default account
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

  /// A factory to get a Account from json
  factory Account.fromJson(Map<String, dynamic> json) =>
      _$AccountFromJson(json);

  /// Parse a Account to json
  Map<String, dynamic> toJson() => _$AccountToJson(this);
}

/// A class who represent the manager data
@JsonSerializable()
class ManagerInformation {
  /// The surname of the manager
  String surname;
  /// The first name of the manager
  String firstname;
  /// The phone number of the manager
  String phoneNumber;
  /// The siren number of the manager
  String sirenNumber;

  ///The initializer of the class
  ManagerInformation({
    required this.surname,
    required this.firstname,
    required this.phoneNumber,
    required this.sirenNumber,
  });

  /// A factory to get a Account by json
  factory ManagerInformation.fromJson(Map<String, dynamic> json) =>
      _$ManagerInformationFromJson(json);

  /// Parse a manager information to json
  Map<String, dynamic> toJson() => _$ManagerInformationToJson(this);
}

/// The enum who represent the role of the user
enum Role {
  /// A lambda user
  @JsonValue('USER')
  user,
  /// A administrator of the application
  @JsonValue('ADMIN')
  admin,
  /// A user who is a manager of one of the proposed establishment
  @JsonValue('MANAGER')
  manager
}
