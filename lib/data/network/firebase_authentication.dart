import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:innerverse/data/model/error/firebase_error.dart';

class FirebaseAuthentication {
  FirebaseAuthentication({required FirebaseAuth firebaseAuth})
      : _firebaseAuth = firebaseAuth;
  final FirebaseAuth _firebaseAuth;

  Future<Either<User?, FirebaseError>> signUp(
      {required String email, required String password}) async {
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return Left(getUser());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        return Right(FirebaseError(message: 'Email already in use'));
      } else {
        return Right(FirebaseError(message: 'Something went wrong'));
      }
    }
  }

  User? getUser() {
    return _firebaseAuth.currentUser;
  }
}
