part of 'alluser_bloc.dart';

abstract class AlluserEvent extends Equatable {
  const AlluserEvent();

  @override
  List<Object> get props => [];
}

class DeleteEvent extends AlluserEvent {
  final String id;
  DeleteEvent(this.id);
}

class UserLoad extends AlluserEvent {
  const UserLoad();

  @override
  List<Object> get props => [];
}
