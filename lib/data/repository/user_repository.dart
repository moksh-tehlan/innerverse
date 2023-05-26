import 'package:dartz/dartz.dart';
import 'package:innerverse/data/model/error/generic_error.dart';
import 'package:innerverse/data/model/user_model.dart';
import 'package:innerverse/data/network/user_calls.dart';

class UserRepository{
  UserRepository({required UserCalls userCalls}):_userCalls = userCalls;
  final UserCalls _userCalls;
  Future<Either<void,GenericError>> addUser(UserModel userModel)async {
    return _userCalls.addUser(userModel);
  }
}