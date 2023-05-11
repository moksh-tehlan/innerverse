part of 'authentication_bloc.dart';

@freezed
class AuthenticationState with _$AuthenticationState {
  const factory AuthenticationState.initial() = _Initial;
  const factory AuthenticationState.loading() = _Loading;
  const factory AuthenticationState.signUpSuccessfull({required User? user}) =
      _SignUpSuccessfull;
  const factory AuthenticationState.signInSuccessfull({required User? user}) =
      _SignInSuccessfull;
  const factory AuthenticationState.error({required String error}) = _Error;
}
