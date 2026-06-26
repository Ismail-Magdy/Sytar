import "package:equatable/equatable.dart";

abstract class SignupState extends Equatable {
  const SignupState();

  @override
  List<Object> get props => [];
}

class SignupInitial extends SignupState {}

class SignupLoading extends SignupState {}

class SignupSuccess extends SignupState {}

class SignupFailure extends SignupState {
  final String errMessage;

  const SignupFailure({required this.errMessage});

  @override
  List<Object> get props => [errMessage];
}
