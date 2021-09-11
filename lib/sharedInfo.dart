import 'package:shared_preferences/shared_preferences.dart';

import 'data/models/user_model.dart';

class SharedInfo {
  static SharedPreferences? sharedPreferences;

 

  //save info logged in to shared preferences
  void sharedLoginSave(UserModel userModel) async {
    sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences!.setString("idUser", userModel.id!);
    sharedPreferences!.setString("username", userModel.name!);
    sharedPreferences!.setString("email", userModel.email!);
    sharedPreferences!.setString("password", userModel.password!);
    sharedPreferences!.setBool("administrator", userModel.administrator!);
    // print(sharedPreferences!.getString("idUser"));
    // print(sharedPreferences!.getString("username"));
  }

  void useridsave(String id) async {
    sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences!.setString("idUser", id);
    // print(sharedPreferences!.getString("idUser"));  // print(sharedPreferences!.getString("username"));
  }

  void usernamesave(String name) async {
    sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences!.setString("username",name );
    // print(sharedPreferences!.getString("idUser"));  // print(sharedPreferences!.getString("username"));
  }

  void emailsave(String email) async {
    sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences!.setString("email",email );
    // print(sharedPreferences!.getString("idUser"));  // print(sharedPreferences!.getString("username"));
  }



  static Future init() async => 
       sharedPreferences = await SharedPreferences.getInstance(); 
  static Future setUserID (String id) async=> 
    await sharedPreferences!.setString("idUser",id);    
  String? getUserID() {
    return sharedPreferences!.getString("idUser");
  }
  String? getUsername() {
    return sharedPreferences!.getString("username");
  }
  String? getEmail() {
    return sharedPreferences!.getString("email");
  }

  String? getPassword() {
    return sharedPreferences!.getString("password");
  }

  bool? isAdministrator(){
    return sharedPreferences!.getBool("administrator");
  }
}
