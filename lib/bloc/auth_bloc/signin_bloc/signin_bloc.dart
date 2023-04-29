import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../service/ApiService.dart';
import 'signin_bloc_event.dart';
import 'signin_bloc_state.dart';

class SignInBloc extends Bloc<SignInEvent, SignInBlocState> {
  final ApiService _apiService;

  SignInBloc({required ApiService apiService})
      : _apiService = apiService,
        super(SignInInitial()) {
    on<SignInButtonPressed>((event, emit) async {
      emit(SignInLoading());

      try {
        Future.delayed(const Duration(seconds: 5));
        await _apiService.loginUser(
            event.userModel.email, event.userModel.password);

        emit(SignInSuccess());
      } catch (err) {
        emit(SignInFailure(errorMessage: err.toString()));
      }
    });
  }
}
