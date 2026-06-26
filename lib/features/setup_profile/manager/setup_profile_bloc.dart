import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sytar/core/helpers/shared_prefrences_helper.dart';
import 'package:sytar/features/setup_profile/data/repos/setup_profile_repo.dart';
import 'setup_profile_event.dart';
import 'setup_profile_state.dart';

class SetupProfileBloc extends Bloc<SetupProfileEvent, SetupProfileState> {
  final SetupProfileRepo setupProfileRepo;

  SetupProfileBloc(this.setupProfileRepo) : super(SetupProfileInitial()) {
    on<SaveProfileDataRequested>((event, emit) async {
      emit(SetupProfileLoading());

      final result = await setupProfileRepo.saveUserProfile(
        university: event.university,
        faculty: event.faculty,
        department: event.department,
        currentLevel: event.currentLevel,
        currentSemester: event.currentSemester,
        totalHours: event.totalHours,
        completedHours: event.completedHours,
        currentGpa: event.currentGpa,
        gpaScale: event.gpaScale,
      );

      await result.fold(
        (failureMessage) async =>
            emit(SetupProfileFailure(errMessage: failureMessage)),
        (_) async {
          // تم نقل السطر هنا ليعمل بنجاح بعد حفظ الفايربيز
          await SharedPrefHelper.setData('isProfileSetupCompleted', true);
          emit(SetupProfileSuccess());
        },
      );
    });
  }
}
