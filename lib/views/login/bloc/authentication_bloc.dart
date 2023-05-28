import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:innerverse/data/model/user_model.dart';
import 'package:innerverse/data/repository/firebase_authentication_repository.dart';
import 'package:innerverse/data/repository/user_repository.dart';
import 'package:innerverse/di/dependency_injection.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'authentication_state.dart';
part 'authentication_event.dart';
part 'authentication_bloc.freezed.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc({
    required FirebaseAuthenticationRepository firebaseAuthenticationRepository,
  })  : _firebaseAuthenticationRepository = firebaseAuthenticationRepository,
        super(const AuthenticationState.initial()) {
    on<_SignUp>(_onSignUp);
    on<_SignIn>(_onSignIn);
    on<_SignInWithGoogle>(_onSignInWithGoogle);
  }

  final FirebaseAuthenticationRepository _firebaseAuthenticationRepository;

  Future<void> _onSignUp(
    _SignUp event,
    Emitter<AuthenticationState> emit,
  ) async {
    emit(const _Loading());
    final authResponse = await _firebaseAuthenticationRepository.signUp(
      email: event.emailAddress,
      password: event.password,
    );
    final userResponse = await event.userRepository.addUser(
      UserModel(
        name: event.name,
        email: event.emailAddress,
        uid: firebaseAuth.currentUser?.uid ?? '',
      ),
    );
    final sharedPref = await SharedPreferences.getInstance();
    await sharedPref.setString('name', event.name);
    authResponse.fold(
      (user) => userResponse.fold(
        (userAdded) => emit(_SignUpSuccessfull(user: user)),
        (error) => emit(_Error(error: error.message)),
      ),
      (error) => emit(_Error(error: error.message)),
    );
  }

  Future<void> _onSignIn(
    _SignIn event,
    Emitter<AuthenticationState> emit,
  ) async {
    emit(const _Loading());
    final response = await _firebaseAuthenticationRepository.signIn(
      email: event.email,
      password: event.password,
    );
    final sharedPref = await SharedPreferences.getInstance();
    final userName = await getIt<UserRepository>().getUserName();
    await sharedPref.setString('name', userName);
    emit(
      response.fold(
        (user) => _SignInSuccessfull(user: user),
        (error) => _Error(error: error.message),
      ),
    );
  }

  Future<void> _onSignInWithGoogle(
    _SignInWithGoogle event,
    Emitter<AuthenticationState> emit,
  ) async {
    final userRepository = getIt<UserRepository>();
    final response = await _firebaseAuthenticationRepository.signInWithGoogle();
    await userRepository.addUser(
      UserModel(
        name: firebaseAuth.currentUser?.displayName ?? '',
        email: firebaseAuth.currentUser?.email ?? '',
        uid: firebaseAuth.currentUser?.uid ?? '',
      ),
    );
    final sharedPref = await SharedPreferences.getInstance();
    await sharedPref.setString(
      'name',
      firebaseAuth.currentUser?.displayName ?? '',
    );
    emit(
      response.fold(
        (user) => _SignInSuccessfull(user: user),
        (error) => _Error(error: error.message),
      ),
    );
  }
}
