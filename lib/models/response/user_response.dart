// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:healthify/models/user_model.dart';

class UserResponse {
  bool? success;
  UserModel? user;
  UserResponse({
    this.success,
    this.user,
  });

  UserResponse copyWith({
    bool? success,
    UserModel? user,
  }) {
    return UserResponse(
      success: success ?? this.success,
      user: user ?? this.user,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'success': success,
      'user': user?.toMap(),
    };
  }

  factory UserResponse.fromMap(Map<String, dynamic> map) {
    return UserResponse(
      success: map['success'] != null ? map['success'] as bool : null,
      user: map['user'] != null
          ? UserModel.fromMap(map['user'] as Map<String, dynamic>)
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserResponse.fromJson(String source) =>
      UserResponse.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'UserResponse(success: $success, user: $user)';

  @override
  bool operator ==(covariant UserResponse other) {
    if (identical(this, other)) return true;

    return other.success == success && other.user == user;
  }

  @override
  int get hashCode => success.hashCode ^ user.hashCode;
}
