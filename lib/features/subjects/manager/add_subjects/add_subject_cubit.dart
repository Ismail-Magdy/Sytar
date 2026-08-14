import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sytar/features/subjects/data/repos/subject_repo.dart';
import 'add_subject_state.dart';

class AddSubjectCubit extends Cubit<AddSubjectState> {
  final SubjectRepo _subjectRepo;

  AddSubjectCubit(this._subjectRepo) : super(AddSubjectInitial());

  Future<void> addSubject({
    required String subjectName,
    required String colorCode,
    required int creditHours,
    required int totalMarks, // التعديل الأول: بقت إجبارية
    String? subjectCode,
    String? instructorName,
    String? targetGrade,
  }) async {
    emit(AddSubjectLoading());
    try {
      await _subjectRepo.addSubject(
        subjectName: subjectName,
        colorCode: colorCode,
        creditHours: creditHours,
        totalMarks: totalMarks, // هتتبعت إجبارية للـ Repo
        subjectCode: subjectCode,
        instructorName: instructorName,
        targetGrade: targetGrade,
      );
      emit(AddSubjectSuccess());
    } catch (e) {
      emit(AddSubjectError(e.toString()));
    }
  }
}
