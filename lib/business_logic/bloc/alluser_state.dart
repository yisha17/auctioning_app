part of 'alluser_bloc.dart';

abstract class AlluserState extends Equatable {
  const AlluserState();

  @override
  List<Object> get props => [];
}

class UserSuccess extends AlluserState {
  final Iterable<UserModel> users;

  UserSuccess([this.users = const []]);

  @override
  List<Object> get props => [users];
}

class LoadingState extends AlluserState {}

class UserFailure extends AlluserState {}
