import 'package:am_adel_market/core/utils/app_imports.dart';

class UserModel extends UserEntity {
  UserModel({
    required super.userName,
    required super.email,
    required super.uId,
    required super.phone,
    required super.password,
    required super.createdAt,
    super.fcmToken,
  });

  factory UserModel.fromFirebaseUser(User user) {
    return UserModel(
      userName: user.displayName ?? '',
      email: user.email ?? '',
      uId: user.uid,
      phone: user.phoneNumber ?? '',
      password: '',
      createdAt: DateTime.now(),
    );
  }

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      userName: json['userName'] ?? '',
      email: json['email'] ?? '',
      uId: json['uId'] ?? '',
      phone: json['phone'] ?? '',
      password: json['password'] ?? '',
      createdAt: DateTime.parse(json['createdAt']),
      fcmToken: json['fcmToken'],
    );
  }

  factory UserModel.fromEntity(UserEntity user) {
    return UserModel(
      userName: user.userName,
      email: user.email,
      uId: user.uId,
      phone: user.phone,
      password: user.password,
      createdAt: user.createdAt,
      fcmToken: user.fcmToken,

    );
  }

  UserEntity toEntity() {
    return UserEntity(
      userName: userName,
      email: email,
      uId: uId,
      phone: phone,
      password: password,
      createdAt: createdAt,
      fcmToken: fcmToken,

    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userName': userName,
      'email': email,
      'uId': uId,
      'phone': phone,
      'password': password,
      'createdAt': createdAt.toIso8601String(),
      'fcmToken': fcmToken,

    };
      }
}
