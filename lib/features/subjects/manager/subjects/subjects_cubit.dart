import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sytar/features/subjects/data/repos/subject_repo.dart';
import 'subjects_state.dart';

class SubjectsCubit extends Cubit<SubjectsState> {
  final SubjectRepo _subjectRepo;

  SubjectsCubit(this._subjectRepo) : super(SubjectsInitial());

  Future<void> fetchCurrentSemesterSubjects() async {
    emit(SubjectsLoading());
    try {
      // TODO: هنجيب دول من البروفايل بعدين
      const String currentLevel = "المستوى الأول";
      const String currentSemester = "الترم الأول";

      final subjects = await _subjectRepo.getSubjectsForCurrentSemester(
        currentLevel,
        currentSemester,
      );
      emit(SubjectsSuccess(subjects));
    } catch (e) {
      emit(SubjectsError(e.toString()));
    }
  }
}
