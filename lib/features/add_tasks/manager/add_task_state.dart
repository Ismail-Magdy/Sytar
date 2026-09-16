import 'package:sytar/features/subjects/data/models/subject_model.dart';

abstract class AddTaskState {}

class AddTaskInitial extends AddTaskState {}

class AddTaskLoading extends AddTaskState {}

class AddTaskSuccess extends AddTaskState {}

class AddTaskError extends AddTaskState {
  final String error;
  AddTaskError(this.error);
}

class AddTaskSubjectsLoading extends AddTaskState {}

class AddTaskSubjectsLoaded extends AddTaskState {
  final List<SubjectModel> subjects;
  AddTaskSubjectsLoaded(this.subjects);
}

class AddTaskSubjectsError extends AddTaskState {
  final String error;
  AddTaskSubjectsError(this.error);
}
