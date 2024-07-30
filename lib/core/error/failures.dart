import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  @override
  List<Object> get props => [];
}

class LocalDbFailure extends Failure {}

class CanNotDeleteThisRecord extends Failure {}
