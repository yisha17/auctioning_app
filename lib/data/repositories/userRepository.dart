

import 'package:bidding_app/data/dataproviders/UserdataProvider.dart';
import 'package:bidding_app/data/models/user_model.dart';

class UserRepository {
  final UserDataProvider dataProvider;
  UserRepository(
     this.dataProvider,
  );

  Future<UserModel> login(UserModel user) async{
    return this.dataProvider.login(user);
  }

  Future<UserModel> signup(UserModel user){
    return this.dataProvider.signup(user);
  }

  Future<UserModel> updateProfile(String id,UserModel user){
    return this.dataProvider.updateProfile(id, user);
  }

  Future<UserModel?> getmyinfo(String id){
    return this.dataProvider.getmyinfo(id);
  }


  Future<void> delete(String id) async {
    this.dataProvider.deleteUser(id);
  }

  Future<List<UserModel>> fetchAllUsers() async{
    return this.dataProvider.fetchAllUsers();
  }


}
