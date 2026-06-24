import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final String message;

  const Failure(this.message);

  @override
  List<Object> get props => [message];
}

class ServerFailure extends Failure {
  const ServerFailure([super.message = "An error occurred with the server"]);
}

class CacheFailure extends Failure {
  const CacheFailure([super.message = "An error occurred with local storage"]);
}

class InvalidDataFailure extends Failure {
  const InvalidDataFailure([super.message = "Invalid data provided"]);
}
