import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../service/ApiService.dart';
import './signup_bloc_event.dart';
import './signup_bloc_state.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  final ApiService _apiService;

  SignUpBloc({required ApiService apiService})
      : _apiService = apiService,
        super(SignUpInitial()) {
    on<SignUpButtonPressed>((event, emit) async {
      emit(SignUpLoading());

      try {
        Future.delayed(const Duration(seconds: 5));
        await _apiService.registerUser(event.userModel.fullName!,
            event.userModel.email!, event.userModel.password!);
        emit(SignUpSuccess());
      } catch (err) {
        emit(SignUpFailure(errorMessage: err.toString()));
      }
    });
  }
}
