// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:healthify/bloc/auth_bloc/form_submission_status.dart';

class SignInBlocState {
  final String email;
  final String password;
  final FormSubmissionStatus formStatus;
  final String errorMessage;

  const SignInBlocState({
    this.email = '',
    this.password = "",
    this.formStatus = const InitialFormStatus(),
    this.errorMessage = "",
  });

  SignInBlocState copyWith({
    String? email,
    String? password,
    FormSubmissionStatus? formStatus,
    String? errorMessage,
  }) {
    return SignInBlocState(
      email: email ?? this.email,
      password: password ?? this.password,
      formStatus: formStatus ?? this.formStatus,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
