import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:innerverse/data/repository/firebase_authentication_repository.dart';
import 'package:dartz/dartz.dart';

part 'authentication_state.dart';
part 'authentication_event.dart';
part 'authentication_bloc.freezed.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc(
      {required FirebaseAuthenticationRepository
          firebaseAuthenticationRepository})
      : _firebaseAuthenticationRepository = firebaseAuthenticationRepository,
        super(const AuthenticationState.initial()) {
    on<_SingUp>(_onSignUp);
  }

  final FirebaseAuthenticationRepository _firebaseAuthenticationRepository;

  Future<void> _onSignUp(
    _SingUp event,
    Emitter<AuthenticationState> emit,
  ) async {
    emit(const _Loading());
    final response = await _firebaseAuthenticationRepository.signUp(
      email: event.emailAddress,
      password: event.password,
    );
    emit(
      response.fold(
        (user) => _SignUpSuccessfull(user: user),
        (error) => _Error(error: error.message),
      ),
    );
  }
}
