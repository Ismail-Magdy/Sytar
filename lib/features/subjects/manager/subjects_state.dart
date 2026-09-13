import 'package:sytar/features/subjects/data/models/subject_model.dart';

abstract class SubjectsState {}

class SubjectsInitial extends SubjectsState {}

class SubjectsLoading extends SubjectsState {}

class SubjectsSuccess extends SubjectsState {
  final List<SubjectModel> subjects;
  SubjectsSuccess(this.subjects);
}

class SubjectsError extends SubjectsState {
  final String error;
  SubjectsError(this.error);
}
