import 'package:equatable/equatable.dart';
import 'package:healthify/models/user_model.dart';

abstract class SignInEvent extends Equatable {
  const SignInEvent();

  @override
  List<Object> get props => [];
}

class SignInButtonPressed extends SignInEvent {
  final UserModel userModel;

  const SignInButtonPressed({required this.userModel});

  @override
  List<Object> get props => [userModel];
}
