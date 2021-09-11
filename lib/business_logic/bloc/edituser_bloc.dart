import 'dart:async';


import 'package:bidding_app/data/dataproviders/UserdataProvider.dart';
import 'package:bidding_app/data/models/models.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../sharedInfo.dart';

part 'edituser_event.dart';
part 'edituser_state.dart';

class EdituserBloc extends Bloc<EdituserEvent, EdituserState> {
  EdituserBloc() : super(EdituserState());
  final sharedInfo = SharedInfo();
  void onEdit(String name,String email,String password,String re_password){
      add(EditEvent(name:name,email: email,password:password,re_password: re_password));
  }
  @override
  Stream<EdituserState> mapEventToState(
    EdituserEvent event,
  ) async* {

    if (event is EditEvent){
      try{
        yield LoadingState();
        await Future.delayed(Duration(seconds: 3));
        var id = sharedInfo.getUserID();
        UserModel user= UserModel(
          name:event.name?.trim().toString(),
          email: event.email?.trim().toString(),
          password:event.password?.trim().toString(),
          re_password: event.re_password?.trim().toString());
        final data = await UserDataProvider().updateProfile(id!, user);
        yield EdituserState(user: data);
      }catch(e){
        yield GetFailureState(e.toString());
      }
    }
    // else if (event is CheckEditEvent){
      
    //   var data = sharedPreferences?.get("idUser");
    //   if(data != null){
    //     yield LoggedInState();
    //   }else{
    //     yield LoggedOutState();
    //   }
    // }
    // else if(event is LogOutEvent){
    //   sharedPreferences = await SharedPreferences.getInstance();
    //   await sharedPreferences?.clear();
    //   yield LoggedOutState();
    // }
    
  }
}
