import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:innerverse/data/model/user_model.dart';
import 'package:innerverse/data/repository/user_repository.dart';
import 'package:innerverse/di/dependency_injection.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'user_state.dart';
part 'user_event.dart';
part 'user_bloc.freezed.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc({required UserRepository userRepository})
      : _userRepository = userRepository,
        super(const UserState.initial()) {
    on<_GetUser>(onGetUser);
  }
  final UserRepository _userRepository;

  Future<void> onGetUser(_GetUser event, Emitter<UserState> emit) async {
    final sharePref = await SharedPreferences.getInstance();
    final userModel = UserModel(
      name: sharePref.getString('name'),
      email: firebaseAuth.currentUser?.email ?? '',
    );
    emit(_UserLoaded(userModel: userModel));
  }
}
