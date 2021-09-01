part of 'edituser_bloc.dart';

class EdituserState  {
  final UserModel ?user;
  const EdituserState({this.user});
  factory EdituserState.initial() => EdituserState();

}
class GetFailureState extends EdituserState{
  final String error;

  GetFailureState(this.error);
}

class LoggedInState extends EdituserState{}
class LoadingState extends EdituserState{}
