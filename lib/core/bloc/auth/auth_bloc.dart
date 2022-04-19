import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:student_grading_app/core/interface/iauth.dart';
import 'package:student_grading_app/core/interface/idatabase.dart';

import '../../model/base_user.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final IAuth auth;
  final IDatabase db;
  AuthBloc({required this.auth, required this.db}) : super(AuthInitial()) {
    on<AutoLoginEvent>((event, emit) async {
      final uid = auth.getCurrentLoggedInId();
      if (uid != null) {
        // Get Details
        final userDetails = await db.getUserDetails(uid);
        if (userDetails != null) {
          emit(Authenticated(currentUser: userDetails));
          return;
        }
      }

      emit(AuthInitial());
    });
    on<AuthenticateEvent>((event, emit) {
      emit(Authenticated(currentUser: event.currentUser));
    });
    on<LogoutEvent>((event, emit) async {
      await auth.logout();
      emit(AuthInitial());
    });
    on<ChangePassword>((event, emit) async {
      final result = await auth.changePassword(event.newPassword);
      if (result.isError) {
        emit(AuthPasswordChangeError(errorMessage: result.message));
      } else {
        emit(AuthPasswordChanged());
        emit(AuthInitial());
      }
    });
  }
}
