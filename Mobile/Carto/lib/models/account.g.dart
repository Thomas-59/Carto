// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'account.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Account _$AccountFromJson(Map<String, dynamic> json) => Account(
      id: (json['id'] as num?)?.toInt(),
      username: json['username'] as String,
      emailAddress: json['emailAddress'] as String,
      password: json['password'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      role: $enumDecode(_$RoleEnumMap, json['role']),
      managerInformation: json['managerInformation'] == null
          ? null
          : ManagerInformation.fromJson(
              json['managerInformation'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$AccountToJson(Account instance) => <String, dynamic>{
      'id': instance.id,
      'username': instance.username,
      'emailAddress': instance.emailAddress,
      'password': instance.password,
      'createdAt': instance.createdAt.toIso8601String(),
      'role': _$RoleEnumMap[instance.role]!,
      'managerInformation': instance.managerInformation,
    };

const _$RoleEnumMap = {
  Role.user: 'USER',
  Role.admin: 'ADMIN',
  Role.manager: 'MANAGER',
};

ManagerInformation _$ManagerInformationFromJson(Map<String, dynamic> json) =>
    ManagerInformation(
      surname: json['surname'] as String,
      firstname: json['firstname'] as String,
      phoneNumber: json['phoneNumber'] as String,
      sirenNumber: json['sirenNumber'] as String,
    );

Map<String, dynamic> _$ManagerInformationToJson(ManagerInformation instance) =>
    <String, dynamic>{
      'surname': instance.surname,
      'firstname': instance.firstname,
      'phoneNumber': instance.phoneNumber,
      'sirenNumber': instance.sirenNumber,
    };
