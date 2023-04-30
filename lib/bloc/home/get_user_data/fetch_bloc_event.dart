import 'package:equatable/equatable.dart';

abstract class FetchUserDataBlocEvent extends Equatable {
  const FetchUserDataBlocEvent();

  @override
  List<Object> get props => [];
}

class GetUserData extends FetchUserDataBlocEvent {
  const GetUserData();

  @override
  List<Object> get props => [];
}
