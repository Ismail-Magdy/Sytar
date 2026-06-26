import 'package:equatable/equatable.dart';

abstract class SetupProfileState extends Equatable {
  const SetupProfileState();

  @override
  List<Object> get props => [];
}

class SetupProfileInitial extends SetupProfileState {}

class SetupProfileLoading extends SetupProfileState {}

class SetupProfileSuccess extends SetupProfileState {}

class SetupProfileFailure extends SetupProfileState {
  final String errMessage;

  const SetupProfileFailure({required this.errMessage});

  @override
  List<Object> get props => [errMessage];
}
