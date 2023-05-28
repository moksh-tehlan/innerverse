import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:innerverse/data/model/error/generic_error.dart';
import 'package:innerverse/data/model/user_model.dart';
import 'package:innerverse/di/dependency_injection.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'collections.dart';

class UserCalls {
  UserCalls({required this.firebaseFirestore});

  final FirebaseFirestore firebaseFirestore;

  Future<Either<bool, GenericError>> addUser(UserModel userModel) async {
    try {
      final userCollection = firebaseFirestore.collection(Collections.users);
      await userCollection.doc(userModel.uid).set(userModel.toJson());
      return left(true);
    } catch (e) {
      return right(GenericError(message: e.toString()));
    }
  }

  Future<Either<UserModel, GenericError>> getUser() async {
    try {
      final collection = await firebaseFirestore
          .collection(Collections.users)
          .doc(firebaseAuth.currentUser?.uid ?? '').get();
      final userModel = UserModel.fromFirestore(collection);
      return left(userModel);
    } catch (e) {
      return right(GenericError(message: e.toString()));
    }
  }

  Future<String> getUserName() async{
    final collection = await firebaseFirestore
        .collection(Collections.users)
        .doc(firebaseAuth.currentUser?.uid ?? '').get();
    final userModel = UserModel.fromFirestore(collection);
    return userModel.name?? '';
  }
}
