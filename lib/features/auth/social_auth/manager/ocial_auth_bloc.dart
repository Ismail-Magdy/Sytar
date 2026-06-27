import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sytar/core/helpers/shared_prefrences_helper.dart';
import 'package:sytar/features/auth/social_auth/data/repos/social_auth_repo.dart';
import 'social_auth_event.dart';
import 'social_auth_state.dart';

class SocialAuthBloc extends Bloc<SocialAuthEvent, SocialAuthState> {
  final SocialAuthRepo socialAuthRepo;

  SocialAuthBloc(this.socialAuthRepo) : super(SocialAuthInitial()) {
    on<GoogleSignInRequested>((event, emit) async {
      emit(SocialAuthLoading());
      final result = await socialAuthRepo.signInWithGoogle();
      await _handleAuthResult(result, emit);
    });

    on<FacebookSignInRequested>((event, emit) async {
      emit(SocialAuthLoading());
      final result = await socialAuthRepo.signInWithFacebook();
      await _handleAuthResult(result, emit);
    });
  }

  // ignore: strict_top_level_inference
  Future<void> _handleAuthResult(result, Emitter<SocialAuthState> emit) async {
    await result.fold(
      (failureMessage) async =>
          emit(SocialAuthFailure(errMessage: failureMessage)),
      (userCredential) async {
        try {
          final String uid = userCredential.user!.uid;
          final DocumentSnapshot userDoc = await FirebaseFirestore.instance
              .collection('users')
              .doc(uid)
              .get();

          bool isProfileSetupCompleted = false;

          if (userDoc.exists && userDoc.data() != null) {
            final data = userDoc.data() as Map<String, dynamic>;
            isProfileSetupCompleted = data['isProfileSetupCompleted'] ?? false;
          } else {
            await FirebaseFirestore.instance.collection('users').doc(uid).set({
              'email': userCredential.user!.email,
              'name': userCredential.user!.displayName ?? '',
              'isProfileSetupCompleted': false,
              'createdAt': FieldValue.serverTimestamp(),
            }, SetOptions(merge: true));
          }

          await SharedPrefHelper.setData(
            'isProfileSetupCompleted',
            isProfileSetupCompleted,
          );
          await SharedPrefHelper.setData('isLoggedIn', true);

          emit(
            SocialAuthSuccess(isProfileSetupCompleted: isProfileSetupCompleted),
          );
        } catch (e) {
          emit(
            SocialAuthFailure(
              errMessage: "حدث خطأ أثناء جلب البيانات: ${e.toString()}",
            ),
          );
        }
      },
    );
  }
}
