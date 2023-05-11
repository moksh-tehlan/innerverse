import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:innerverse/data/model/error/firebase_error.dart';

class FirebaseAuthentication {
  FirebaseAuthentication({required FirebaseAuth firebaseAuth})
      : _firebaseAuth = firebaseAuth;
  final FirebaseAuth _firebaseAuth;

  Future<Either<User?, FirebaseError>> signUp({
    required String email,
    required String password,
  }) async {
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return Left(getUser());
    } on FirebaseAuthException catch (e) {
      return Right(FirebaseError(code:e.code));
    }
  }

  Future<Either<User?, FirebaseError>> signIn({
    required String email,
    required String password,
  }) async{
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return Left(getUser());
    } on FirebaseAuthException catch (e) {
      return Right(FirebaseError(code:e.code));
    }
  }

  Future<Either<User?,FirebaseError>> signInWithGoogle() async {
    try{
      final googleUser = await GoogleSignIn().signIn();

      final googleAuth = await googleUser?.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      await FirebaseAuth.instance.signInWithCredential(credential);
      return Left(getUser());

    } on FirebaseAuthException catch(e){
      return Right(FirebaseError(code: e.code));
    }
  }

  User? getUser() {
    return _firebaseAuth.currentUser;
  }
}
