import "package:flutter_bloc/flutter_bloc.dart";
import "package:sytar/features/auth/sign_up/data/repos/signup_repo.dart";
import "signup_event.dart";
import "signup_state.dart";

class SignupBloc extends Bloc<SignupEvent, SignupState> {
  final SignupRepo signupRepo;

  SignupBloc(this.signupRepo) : super(SignupInitial()) {
    on<SignupRequested>((event, emit) async {
      emit(SignupLoading());

      final result = await signupRepo.userSignup(
        name: event.name,
        email: event.email,
        password: event.password,
      );

      result.fold(
        (failureMessage) {
          emit(SignupFailure(errMessage: failureMessage));
        },
        (userModel) {
          emit(SignupSuccess());
        },
      );
    });
  }
}
