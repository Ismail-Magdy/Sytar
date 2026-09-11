import '../../data/models/subject_model.dart';

abstract class SubjectDetailsState {}

class SubjectDetailsInitial extends SubjectDetailsState {}

class SubjectDetailsUpdateLoading extends SubjectDetailsState {}

class SubjectDetailsUpdateSuccess extends SubjectDetailsState {
  final SubjectModel updatedSubject;
  SubjectDetailsUpdateSuccess(this.updatedSubject);
}

class SubjectDetailsUpdateError extends SubjectDetailsState {
  final String error;
  SubjectDetailsUpdateError(this.error);
}
