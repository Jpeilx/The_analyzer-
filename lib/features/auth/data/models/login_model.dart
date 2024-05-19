import 'package:equatable/equatable.dart';

class LoginModel extends Equatable {
  final String? message;
  final String? token;
  final String? role;
  final String? username;
  final String? statusCode;

  const LoginModel({
    this.message,
    this.token,
    this.role,
    this.username,
    this.statusCode,
  });

  factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
        message: json['message'] as String?,
        token: json['token'] as String?,
        role: json['role'] as String?,
        username: json['username'] as String?,
        statusCode: json['statusCode'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'message': message,
        'token': token,
        'role': role,
        'username': username,
        'statusCode': statusCode,
      };

  @override
  List<Object?> get props => [message, token, role, username, statusCode];
}
