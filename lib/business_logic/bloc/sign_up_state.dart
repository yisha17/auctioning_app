part of 'sign_up_bloc.dart';

class SignupState {
  final UserModel? user;

  const SignupState({this.user});

  factory SignupState.initial() => SignupState();
}

class GetFailureState extends SignupState {
  final String error;

  GetFailureState(this.error);
}

class LoggedInState extends SignupState {}

class LoggedOutState extends SignupState {}

class LoadingState extends SignupState {}
