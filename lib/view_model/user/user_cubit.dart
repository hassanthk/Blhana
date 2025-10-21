import 'package:blhana_app/repository/user_repo.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  final UserRepo repo;
  UserCubit(this.repo) : super(UserInitial());
  
  Future<void> loadUserData() async {
    emit(UserLoading());
    try {
      final data = await repo.getUserData();
      if (data == null) {
        emit(UserError('No user found'));
        return;
      }

      emit(
        UserLoaded(
          firstName: data['first name'] ?? '',
          lastName: data['last name'] ?? '',
          email: data['email'] ?? '',
        ),
      );
    } catch (e) {
      emit(UserError(e.toString()));
    }
  }

  Future<void> logout() async {
    try {
      await repo.logout();
      emit(UserLoggedOut());
    } catch (e) {
      emit(UserError('Failed to log out: $e'));
    }
  }
}
