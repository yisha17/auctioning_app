part of 'signup_bloc.dart';

abstract class SignupEvent extends Equatable {
  const SignupEvent();

  @override
  List<Object> get props => [];
}

class LoginEvent extends SignupEvent {
  final String? name;
  final String? email;
  final String? password;
  final String? re_password;

  LoginEvent({this.name, this.email, this.password, this.re_password});
}

class LogOutEvent extends SignupEvent {}

class CheckSignupEvent extends SignupEvent {}
