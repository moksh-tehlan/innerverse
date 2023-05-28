part of 'authentication_bloc.dart';

@freezed
class AuthenticationEvent with _$AuthenticationEvent {
  const factory AuthenticationEvent.signup({
    required UserRepository userRepository,
    required String emailAddress,
    required String password,
    required String name,
  }) = _SignUp;
  const factory AuthenticationEvent.signin({
    required String email,
    required String password,
  }) = _SignIn;
  const factory AuthenticationEvent.signInWithGoogle() = _SignInWithGoogle;
}
