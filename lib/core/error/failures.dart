import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final String? message;
  final String? stacktrace;

  Failure({this.message, this.stacktrace});

  @override
  List<Object> get props => [];
}

class UnknownFailure extends Failure {
  UnknownFailure({super.message, super.stacktrace});
}

class LocalDbFailure extends Failure {}

class CanNotExecuteFailure extends Failure {}

class CanNotGetFailure extends Failure {}
