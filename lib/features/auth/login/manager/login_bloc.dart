import "package:cloud_firestore/cloud_firestore.dart";
import "package:firebase_auth/firebase_auth.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:sytar/core/helpers/shared_prefrences_helper.dart";
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

      await result.fold(
        (failureMessage) async =>
            emit(LoginFailure(errMessage: failureMessage)),
        (userCredential) async {
          final String uid = FirebaseAuth.instance.currentUser!.uid;
          final DocumentSnapshot userDoc = await FirebaseFirestore.instance
              .collection('users')
              .doc(uid)
              .get();

          bool isProfileSetupCompleted = false;
          if (userDoc.exists && userDoc.data() != null) {
            final data = userDoc.data() as Map<String, dynamic>;
            isProfileSetupCompleted = data['isProfileSetupCompleted'] ?? false;
          }

          await SharedPrefHelper.setData(
            'isProfileSetupCompleted',
            isProfileSetupCompleted,
          );

          emit(LoginSuccess(isProfileSetupCompleted: isProfileSetupCompleted));
        },
      );
    });
  }
}
