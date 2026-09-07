import 'dart:io';

class LoginRequest{
  final String email;
  final String password;

  LoginRequest({required this.email, required this.password});
}


class RegisterRequest{
  final String email;
  final String password;
  final String userName;
 // final File imageFile;
  final String phone;

  RegisterRequest({
    required this.email,
    required this.password,
    required this.userName,
 //   required this.imageFile,
    required this.phone,
  });
}