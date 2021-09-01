part of 'edituser_bloc.dart';

abstract class EdituserEvent extends Equatable {
  const EdituserEvent();

  @override
  List<Object> get props => [];
}
class EditEvent extends EdituserEvent{
  final String ?name;
  final String ?email;
  final String ?password;
  final String ?re_password;

  EditEvent({this.name,this.email, this.password,this.re_password});
}

class CheckEditEvent extends EdituserEvent{}
