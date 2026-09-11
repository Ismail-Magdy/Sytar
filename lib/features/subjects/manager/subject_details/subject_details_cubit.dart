import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/models/subject_model.dart';
import '../../data/repos/subject_repo.dart';
import 'subject_details_state.dart';

class SubjectDetailsCubit extends Cubit<SubjectDetailsState> {
  final SubjectRepo _subjectRepo;

  SubjectDetailsCubit(this._subjectRepo) : super(SubjectDetailsInitial());

  Future<void> updateSubject(SubjectModel updatedSubject) async {
    emit(SubjectDetailsUpdateLoading());
    try {
      await _subjectRepo.updateSubject(updatedSubject);

      emit(SubjectDetailsUpdateSuccess(updatedSubject));
    } catch (e) {
      emit(SubjectDetailsUpdateError(e.toString()));
    }
  }
}
