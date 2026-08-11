import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sytar/features/subjects/data/models/subject_model.dart';
import 'package:sytar/features/subjects/data/repos/subject_repo.dart';
import 'package:sytar/features/subjects/manager/add_subjects/add_subject_state.dart';

class AddSubjectCubit extends Cubit<AddSubjectState> {
  final SubjectRepo _subjectRepo;

  AddSubjectCubit(this._subjectRepo) : super(AddSubjectInitial());

  Future<void> addSubject({
    required String subjectName,
    required String level,
    required String semester,
    required String colorCode,
  }) async {
    emit(AddSubjectLoading());
    try {
      final subject = SubjectModel(
        id: "", // Firestore auto-generates this for new documents
        subjectName: subjectName,
        level: level,
        semester: semester,
        colorCode: colorCode,
      );
      await _subjectRepo.addSubject(subject);
      emit(AddSubjectSuccess());
    } catch (e) {
      emit(AddSubjectError(e.toString()));
    }
  }
}
