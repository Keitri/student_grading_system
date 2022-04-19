import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:student_grading_app/core/interface/iauth.dart';
import 'package:student_grading_app/core/interface/idatabase.dart';
import 'package:student_grading_app/core/model/base_user.dart';
import 'package:student_grading_app/view/values/apptext.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final IAuth auth;
  final IDatabase db;
  LoginBloc({required this.auth, required this.db}) : super(LoginInitial()) {
    on<StartLoginEvent>((event, emit) async {
      emit(LoginLoading());
      if (event.mobileNumber.isEmpty) {
        emit(const LoginError(errorMessage: AppText.mobileNumberRequired));
        return;
      }

      if (event.password.isEmpty) {
        emit(const LoginError(errorMessage: AppText.passwordRequired));
        return;
      }

      final result = await auth.login(event.mobileNumber, event.password);
      if (result.isError) {
        emit(LoginError(errorMessage: result.message));
        return;
      } else {
        // Get User Details from Database
        final userDetails = await db.getUserDetails(result.args as String);
        if (userDetails != null) {
          // Successful Login
          emit(LoginSuccess(currentUser: userDetails));
        } else {
          // Show Error Message
          emit(const LoginError(errorMessage: AppText.userNotFound));
        }
      }
    });
  }
}
