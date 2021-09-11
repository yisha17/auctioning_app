import 'dart:async';


import 'package:bidding_app/data/dataproviders/UserdataProvider.dart';
import 'package:bidding_app/data/models/models.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc extends Bloc<AuthenticationEvent, AuthenticationState> {
  
  
  AuthenticationBloc() : super(AuthenticationState());

  void onLogin(String email,String password){
      add(LoginEvent(email: email,password:password));
  }
  void onLogout(){
    add(LogOutEvent());
  }

  SharedPreferences ?sharedPreferences;
  @override
  Stream<AuthenticationState> mapEventToState(
    AuthenticationEvent event,
  ) async* {
    
    if (event is LoginEvent){
      try{
        yield LoadingState();
        await Future.delayed(Duration(seconds: 3));
        // var url = '/auction/auth/user/login';
        // Map<String,dynamic> jsonBody = {
        //   'email':event.email!.trim().toString(),
        //   'password': event.password!.trim().toString(),
        // };
        UserModel user= UserModel(email: event.email?.trim().toString(),password:event.password?.trim().toString());
        final data = await UserDataProvider().login(user);
        yield AuthenticationState(user: data);
      }catch(e){
        yield GetFailureState(e.toString());
      }
    }
    else if (event is CheckLoginEvent){
      sharedPreferences = await  SharedPreferences.getInstance();
      var data = sharedPreferences?.get("idUser");
      if(data != null){
        yield LoggedInState();
      }else{
        yield LoggedOutState();
      }
    }
    else if(event is LogOutEvent){
      sharedPreferences = await SharedPreferences.getInstance();
      await sharedPreferences?.clear();
      yield LoggedOutState();
    }
    

    
  }
}
