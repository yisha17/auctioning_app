part of 'authentication_bloc.dart';

abstract class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();

  @override
  List<Object> get props => [];
}

class LoginEvent extends AuthenticationEvent {
  final String? email;
  final String? password;

  LoginEvent({this.email, this.password});
}

class LogOutEvent extends AuthenticationEvent {}

class CheckLoginEvent extends AuthenticationEvent {}

// class EmailOnChangedEvent extends AuthenticationEvent {
//   final String email;
//   EmailOnChangedEvent({
//     required this.email,
//   });
// }

// class PasswordOnChangedEvent extends AuthenticationEvent {
//   final String password;
//   PasswordOnChangedEvent({
//     required this.password,
//   });
// }

// class OnSubmitEvent extends AuthenticationEvent{
//   late final UserModel user;
//   @override
//   List<Object> get props => [user];

// }


