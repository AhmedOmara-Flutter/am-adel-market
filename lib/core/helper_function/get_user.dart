import 'dart:convert';

import 'package:am_adel_market/core/utils/app_imports.dart';

UserEntity getUser() {
  var data = CacheHelper.getData(key: 'userData');
  if (data == null || data.isEmpty) {
    return UserModel(
      userName: '',
      email: '',
      phone: '',
      uId: '',
      password: '',
      createdAt: DateTime.now(),
    );
  }

  var jsonData = jsonDecode(data);
  var userEntity = UserModel.fromJson(jsonData);
  return userEntity;
}
