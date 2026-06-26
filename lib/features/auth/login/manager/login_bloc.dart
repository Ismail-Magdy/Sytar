import "package:flutter_bloc/flutter_bloc.dart";
import "package:sytar/features/auth/login/data/repos/login_repo.dart";
import "login_event.dart";
import "login_state.dart";

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginRepo loginRepo;

  LoginBloc(this.loginRepo) : super(LoginInitial()) {
    on<LoginRequested>((event, emit) async {
      emit(LoginLoading());

      final result = await loginRepo.userLogin(
        email: event.email,
        password: event.password,
      );

      result.fold(
        (failureMessage) => emit(LoginFailure(errMessage: failureMessage)),
        (userCredential) => emit(LoginSuccess()),
      );
    });
  }
}
