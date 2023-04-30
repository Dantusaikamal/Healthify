// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class UserModel {
  String? sId;
  String? fullName;
  String? email;
  String? password;
  String? gender;
  int? weight;
  int? height;
  int? bmi;
  String? createdAt;

  UserModel({
    this.sId,
    this.fullName,
    this.email,
    this.password,
    this.gender,
    this.weight,
    this.height,
    this.bmi,
    this.createdAt,
  });

  UserModel copyWith({
    String? sId,
    String? fullName,
    String? email,
    String? password,
    String? gender,
    int? weight,
    int? height,
    int? bmi,
    String? createdAt,
  }) {
    return UserModel(
      sId: sId ?? this.sId,
      fullName: fullName ?? this.fullName,
      email: email ?? this.email,
      password: password ?? this.password,
      gender: gender ?? this.gender,
      weight: weight ?? this.weight,
      height: height ?? this.height,
      bmi: bmi ?? this.bmi,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'sId': sId,
      'fullName': fullName,
      'email': email,
      'password': password,
      'gender': gender,
      'weight': weight,
      'height': height,
      'bmi': bmi,
      'createdAt': createdAt,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      sId: map['sId'] != null ? map['sId'] as String : null,
      fullName: map['fullName'] != null ? map['fullName'] as String : null,
      email: map['email'] != null ? map['email'] as String : null,
      password: map['password'] != null ? map['password'] as String : null,
      gender: map['gender'] != null ? map['gender'] as String : null,
      weight: map['weight'] != null ? map['weight'] as int : null,
      height: map['height'] != null ? map['height'] as int : null,
      bmi: map['bmi'] != null ? map['bmi'] as int : null,
      createdAt: map['createdAt'] != null ? map['createdAt'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'UserModel(sId: $sId, fullName: $fullName, email: $email, password: $password, gender: $gender, weight: $weight, height: $height, bmi: $bmi, createdAt: $createdAt)';
  }

  @override
  bool operator ==(covariant UserModel other) {
    if (identical(this, other)) return true;

    return other.sId == sId &&
        other.fullName == fullName &&
        other.email == email &&
        other.password == password &&
        other.gender == gender &&
        other.weight == weight &&
        other.height == height &&
        other.bmi == bmi &&
        other.createdAt == createdAt;
  }

  @override
  int get hashCode {
    return sId.hashCode ^
        fullName.hashCode ^
        email.hashCode ^
        password.hashCode ^
        gender.hashCode ^
        weight.hashCode ^
        height.hashCode ^
        bmi.hashCode ^
        createdAt.hashCode;
  }
}
