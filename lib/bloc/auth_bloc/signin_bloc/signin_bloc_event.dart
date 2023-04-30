abstract class SignInEvent {
  const SignInEvent();
}

class SignInEmail extends SignInEvent {
  final String email;

  const SignInEmail({required this.email});
}

class SignInPassword extends SignInEvent {
  final String password;

  const SignInPassword({required this.password});
}

class SignInSubmitted extends SignInEvent {}
