import 'package:equatable/equatable.dart';
import 'package:healthify/models/user_model.dart';

abstract class FetchUserDataBlocState extends Equatable {
  const FetchUserDataBlocState();

  @override
  List<Object> get props => [];
}

class FetchingDataInitial extends FetchUserDataBlocState {}

class FetchingDataLoading extends FetchUserDataBlocState {}

class FetchingDataSuccess extends FetchUserDataBlocState {
  final UserModel user;

  const FetchingDataSuccess({required this.user});
}

class FetchingDataFailure extends FetchUserDataBlocState {
  final String errorMessage;

  const FetchingDataFailure({required this.errorMessage});
}
