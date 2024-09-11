import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';


@JsonSerializable()
class UserModel {
  final String id;
  final String username;
  final String email;
  final String? phoneNumber;
  final String avatar;

  UserModel({
    required this.id,
    required this.username,
    required this.email,
    this.phoneNumber,
    required this.avatar,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => _$UserModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}
