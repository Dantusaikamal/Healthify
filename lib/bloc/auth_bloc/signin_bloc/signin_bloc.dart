// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:healthify/bloc/auth_bloc/form_submission_status.dart';
import 'package:healthify/repository/auth_repo/auth_repository.dart';

import 'signin_bloc_event.dart';
import 'signin_bloc_state.dart';

class SignInBloc extends Bloc<SignInEvent, SignInBlocState> {
  final AuthRepository authRepo;

  SignInBloc({
    required this.authRepo,
  }) : super(const SignInBlocState()) {
    on<SignInEmail>(
      (event, emit) => {
        emit(state.copyWith(email: event.email)),
      },
    );

    on<SignInPassword>(
      (event, emit) => {
        emit(state.copyWith(password: event.password)),
      },
    );

    on<SignInSubmitted>(
      (event, emit) async {
        emit(state.copyWith(formStatus: FormSubmitting()));

        await authRepo.signInUser(state.email, state.password);

        await Future.delayed(const Duration(seconds: 5), () {
          emit(state.copyWith(formStatus: SubmissionSuccess()));
        });
      },
    );
  }
}
