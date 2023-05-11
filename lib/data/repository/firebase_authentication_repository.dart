import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:innerverse/data/model/error/firebase_error.dart';
import 'package:innerverse/data/network/firebase_authentication.dart';

class FirebaseAuthenticationRepository {
  FirebaseAuthenticationRepository({
    required FirebaseAuthentication firebaseAuthentication,
  }) : _firebaseAuthentication = firebaseAuthentication;
  final FirebaseAuthentication _firebaseAuthentication;

  Future<Either<User?, FirebaseError>> signUp(
      {required String email, required String password}) {
    return _firebaseAuthentication.signUp(email: email, password: password);
  }

  Future<Either<User?, FirebaseError>> signIn({
    required String email,
    required String password,
  }) {
    return _firebaseAuthentication.signIn(
      email: email,
      password: password,
    );
  }

  Future<Either<User?, FirebaseError>> signInWithGoogle() {
    return _firebaseAuthentication.signInWithGoogle();
  }

  User? getUser() {
    return _firebaseAuthentication.getUser();
  }
}
