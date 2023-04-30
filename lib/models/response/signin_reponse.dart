// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:healthify/models/user_model.dart';

class SignInResponse {
  bool? success;
  String? message;
  UserModel? user;
  String? token;
  SignInResponse({
    this.success,
    this.message,
    this.user,
    this.token,
  });

  SignInResponse copyWith({
    bool? success,
    String? message,
    UserModel? user,
    String? token,
  }) {
    return SignInResponse(
      success: success ?? this.success,
      message: message ?? this.message,
      user: user ?? this.user,
      token: token ?? this.token,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'success': success,
      'message': message,
      'user': user?.toMap(),
      'token': token,
    };
  }

  factory SignInResponse.fromMap(Map<String, dynamic> map) {
    return SignInResponse(
      success: map['success'] != null ? map['success'] as bool : null,
      message: map['message'] != null ? map['message'] as String : null,
      user: map['user'] != null
          ? UserModel.fromMap(map['user'] as Map<String, dynamic>)
          : null,
      token: map['token'] != null ? map['token'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory SignInResponse.fromJson(String source) =>
      SignInResponse.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'SignInResponse(success: $success, message: $message, user: $user, token: $token)';
  }

  @override
  bool operator ==(covariant SignInResponse other) {
    if (identical(this, other)) return true;

    return other.success == success &&
        other.message == message &&
        other.user == user &&
        other.token == token;
  }

  @override
  int get hashCode {
    return success.hashCode ^ message.hashCode ^ user.hashCode ^ token.hashCode;
  }
}
