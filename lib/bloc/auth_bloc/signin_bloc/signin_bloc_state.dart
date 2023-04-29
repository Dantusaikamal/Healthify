import 'package:equatable/equatable.dart';

abstract class SignInBlocState extends Equatable {
  const SignInBlocState();

  @override
  List<Object> get props => [];
}

class SignInInitial extends SignInBlocState {}

class SignInLoading extends SignInBlocState {}

class SignInSuccess extends SignInBlocState {}

class SignInFailure extends SignInBlocState {
  final String errorMessage;

  const SignInFailure({required this.errorMessage});
}
