import 'package:auction_real/data/dataproviders/UserdataProvider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:auction_real/data/models/models.dart';
import 'package:shared_preferences/shared_preferences.dart';
part 'signup_event.dart';
part 'signup_state.dart';

class SignupBloc extends Bloc<SignupEvent, SignupState> {
  SignupBloc() : super(SignupState());
  void onSignup(
      String name, String email, String password, String re_password) {
    add(LoginEvent(
        name: name,
        email: email,
        password: password,
        re_password: re_password));
  }

  void onLogout() {
    add(LogOutEvent());
  }

  SharedPreferences? sharedPreferences;
  @override
  Stream<SignupState> mapEventToState(SignupEvent event) async* {
    if (event is LoginEvent) {
      try {
        yield LoadingState();
        await Future.delayed(Duration(seconds: 3));
        UserModel user = UserModel(
            name: event.name?.trim().toString(),
            email: event.email?.trim().toString(),
            password: event.password?.trim().toString(),
            re_password: event.re_password?.trim().toString());
        final data = await UserDataProvider().signup(user);
        yield SignupState(user: data);
      } catch (e) {
        yield GetFailureState(e.toString());
      }
    } else if (event is CheckSignupEvent) {
      sharedPreferences = await SharedPreferences.getInstance();
      var data = sharedPreferences?.get("idUser");
      if (data != null) {
        yield LoggedInState();
      } else {
        yield LoggedOutState();
      }
    } else if (event is LogOutEvent) {
      sharedPreferences = await SharedPreferences.getInstance();
      await sharedPreferences?.clear();
      yield LoggedOutState();
    }
  }
}
