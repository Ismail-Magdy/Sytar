import 'package:flutter_bloc/flutter_bloc.dart';
import '../../subjects/data/models/subject_model.dart';
import '../../subjects/data/repos/subject_repo.dart';
import 'subject_details_state.dart';

class SubjectDetailsCubit extends Cubit<SubjectDetailsState> {
  final SubjectRepo _subjectRepo;

  SubjectDetailsCubit(this._subjectRepo) : super(SubjectDetailsInitial());

  Future<void> updateSubject(SubjectModel updatedSubject) async {
    emit(SubjectDetailsUpdateLoading());
    try {
      SubjectModel finalSubject = updatedSubject;
      
      if (!finalSubject.isGradeOverridden) {
        final currentBreakdownSum = finalSubject.finalExamTotal +
            (finalSubject.midterm1Total ?? 0) +
            (finalSubject.midterm2Total ?? 0) +
            (finalSubject.courseworkTotal ?? 0);

        bool allGradesEntered = true;
        if (finalSubject.finalExamTotal > 0 && finalSubject.obtainedFinal == null) allGradesEntered = false;
        if ((finalSubject.midterm1Total ?? 0) > 0 && finalSubject.obtainedMidterm1 == null) allGradesEntered = false;
        if ((finalSubject.midterm2Total ?? 0) > 0 && finalSubject.obtainedMidterm2 == null) allGradesEntered = false;
        if ((finalSubject.courseworkTotal ?? 0) > 0 && finalSubject.obtainedCoursework == null) allGradesEntered = false;

        // If no components are configured, it's not "all grades entered"
        if (currentBreakdownSum == 0) allGradesEntered = false;

        if (allGradesEntered && currentBreakdownSum == finalSubject.totalMarks) {
          final totalObtained = (finalSubject.obtainedFinal ?? 0) +
              (finalSubject.obtainedMidterm1 ?? 0) +
              (finalSubject.obtainedMidterm2 ?? 0) +
              (finalSubject.obtainedCoursework ?? 0);
          
          final percentage = (totalObtained / finalSubject.totalMarks) * 100;
          String grade = _calculateGradeFromPercentage(percentage);
          
          finalSubject = finalSubject.copyWith(finalCalculatedGrade: grade);
        }
      }

      await _subjectRepo.updateSubject(finalSubject);
      emit(SubjectDetailsUpdateSuccess(finalSubject));
    } catch (e) {
      emit(SubjectDetailsUpdateError(e.toString()));
    }
  }

  Future<void> overrideFinalGrade(SubjectModel subject, String newGrade) async {
    final updatedSubject = subject.copyWith(
      finalCalculatedGrade: newGrade,
      isGradeOverridden: true,
    );
    await updateSubject(updatedSubject);
  }

  String _calculateGradeFromPercentage(double percentage) {
    if (percentage >= 90) return 'A+';
    if (percentage >= 85) return 'A';
    if (percentage >= 80) return 'B+';
    if (percentage >= 75) return 'B';
    if (percentage >= 70) return 'C+';
    if (percentage >= 65) return 'C';
    if (percentage >= 60) return 'D';
    return 'F';
  }
}
