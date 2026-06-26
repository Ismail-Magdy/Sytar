import "package:equatable/equatable.dart";

abstract class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object> get props => [];
}

class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {}

class LoginSuccess extends LoginState {
  final bool isProfileSetupCompleted;

  const LoginSuccess({required this.isProfileSetupCompleted});

  @override
  List<Object> get props => [isProfileSetupCompleted];
}

class LoginFailure extends LoginState {
  final String errMessage;

  const LoginFailure({required this.errMessage});

  @override
  List<Object> get props => [errMessage];
}
