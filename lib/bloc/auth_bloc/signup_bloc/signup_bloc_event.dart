// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

import 'package:healthify/models/user_model.dart';

abstract class SignUpEvent extends Equatable {
  const SignUpEvent();

  @override
  List<Object> get props => [];
}

class SignUpButtonPressed extends SignUpEvent {
  final UserModel userModel;

  const SignUpButtonPressed({required this.userModel});

  @override
  List<Object> get props => [userModel];
}
