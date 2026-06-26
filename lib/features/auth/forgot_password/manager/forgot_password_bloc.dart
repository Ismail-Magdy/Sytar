import "package:flutter_bloc/flutter_bloc.dart";
import "package:sytar/features/auth/forgot_password/data/repos/forgot_password_repo.dart";
import "forgot_password_event.dart";
import "forgot_password_state.dart";

class ForgotPasswordBloc
    extends Bloc<ForgotPasswordEvent, ForgotPasswordState> {
  final ForgotPasswordRepo forgotPasswordRepo;

  ForgotPasswordBloc(this.forgotPasswordRepo) : super(ForgotPasswordInitial()) {
    on<ResetPasswordRequested>((event, emit) async {
      emit(ForgotPasswordLoading());

      final result = await forgotPasswordRepo.resetPassword(email: event.email);

      result.fold(
        (failureMessage) =>
            emit(ForgotPasswordFailure(errMessage: failureMessage)),
        (_) => emit(ForgotPasswordSuccess()),
      );
    });
  }
}
