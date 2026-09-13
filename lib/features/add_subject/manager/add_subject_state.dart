abstract class AddSubjectState {}

class AddSubjectInitial extends AddSubjectState {}

class AddSubjectLoading extends AddSubjectState {}

class AddSubjectSuccess extends AddSubjectState {}

class AddSubjectError extends AddSubjectState {
  final String error;

  AddSubjectError(this.error);
}
