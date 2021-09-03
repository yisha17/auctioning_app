part of 'authentication_bloc.dart';

class AuthenticationState {
  final UserModel? user;

  const AuthenticationState({this.user});

  factory AuthenticationState.initial() => AuthenticationState();
}

class GetFailureState extends AuthenticationState {
  final String error;

  GetFailureState(this.error);
}

class LoggedInState extends AuthenticationState {}

class LoggedOutState extends AuthenticationState {}

class LoadingState extends AuthenticationState {}

// class LoginState extends AuthenticationState {
//   final String email;
//   final String password;
//   final FormStatus formStatus;
  
//   LoginState({
//    this.email = '',
//     this.password = '',
//     this.formStatus = const InitialStatus()
//   });

//   LoginState copyWith({
//     String ?email,
//     String ?password,
//     FormStatus ?formStatus,
//   }){
//     return LoginState(
//       email: email ?? this.email,
//       password:password ?? this.password,
//       formStatus: formStatus ?? this.formStatus,
//     );
//   }


// }



// abstract class FormStatus{
//   const FormStatus();
// }
// class InitialStatus extends FormStatus{
//   const InitialStatus();
// }

// class FormSubmitting extends FormStatus{}

// class SubmissionSuccess extends FormStatus{}

// class SubmissionFailed extends FormStatus{
//   final Exception exception;
//   SubmissionFailed(this.exception);
// }