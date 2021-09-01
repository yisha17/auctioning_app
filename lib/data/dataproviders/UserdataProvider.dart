import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:auction_real/data/models/models.dart';

//"" + resource.url
// class APIWeb{
//   Future<Response> load(APIService<http.Response> resource) async {
//     final response = await http.get(Uri.http('127.0.0.1:5000', '/auction/auth/user/login'));
//     if (response.statusCode == 200){
//       return resource.parse(response);
//     }else{
//       throw Exception(response.statusCode);
//     }
//   }
// }
class UserDataProvider {
  static final String base_url = '127.0.0.1:5000';
    final String path = '/auction/auth/user';
  Future<UserModel> load(UserModel user) async {
    final response =
        await http.get(Uri.http(base_url, '/auction/auth/user/login'));
    if (response.statusCode == 200) {
      return UserModel.fromJSON(jsonDecode(response.body));
    } else {
      throw Exception("can not login");
    }
  }
  Future<UserModel> login(UserModel user) async {
    final http.Response response =
        await http.post(Uri.http(base_url, '/auction/auth/user/login'),
            headers: <String, String>{
              "Content-Type": "application/json;charset=UTF-8",
              "Access-Control-Allow-Origin": "*",
              "Access-Control-Allow-Methods":
                  "GET, POST, PATCH, PUT, DELETE, OPTIONS",
              "Access-Control-Allow-Headers":
                  "Origin, Content-Type, X-Auth-Token"
            },
            body: jsonEncode({"email": user.email, "password": user.password}));
if (response.statusCode == 200) {
      print(response.body);
      return UserModel.fromJSON(jsonDecode(response.body));
    } else {
      throw Exception("can not login");
    }
  }

  Future<UserModel> signup(UserModel user) async {
    final response = await http.post(Uri.http(base_url, '/auction/auth/user'),
        headers: <String, String>{
          "Content-Type": "application/json;charset=UTF-8",
          "Access-Control-Allow-Origin": "*",
        },
        body: jsonEncode({
          "username": user.name,
          "email": user.email,
          "password": user.password,
          "re_password": user.re_password,
          "administrator": false
        }));

    if (response.statusCode == 200) {
      return UserModel.fromJSON(jsonDecode(response.body));
    } else {
      throw Exception("can not signup");
    }
  }

  Future<List<UserModel>> fetchAllUsers() async {
    final response = await http.get(Uri.http(base_url, '/auction/auth/user'));
    if (response.statusCode == 200) {
      final users = jsonDecode(response.body) as List;
      print(users);

      List<UserModel> usersList =
          users.map((e) => UserModel.fromJSON(e)).toList();

      return usersList;
    } else {
      throw Exception("Could not fetch users");
    }
  }

  Future<UserModel?> getmyinfo(String id) async{
    final response = await http.get(Uri.http(base_url, '/auction/auth/user/$id'));

    if (response.statusCode == 200){
      UserModel.fromJSON(jsonDecode(response.body));
    }else {
      throw Exception("can't get user");
    }
  }

  Future<UserModel> updateProfile(String id,UserModel user) async{
    final response = await http.put(Uri.http(base_url, '/auction/auth/user/$id'),
    headers: <String, String>{"Content-Type": "application/json"},
        body: jsonEncode({
          "id": id,
          "username": user.name,
          "email": user.email,
          "password": user.password,
          "re_password": user.re_password,
          "administrator": user.administrator
        }));

        if (response.statusCode == 200) {
      return UserModel.fromJSON(jsonDecode(response.body));
    } else {
      throw Exception("Could not update the user");
    }
  }

  Future<void> deleteUser(String id) async {
    final response = await http.delete(Uri.http(base_url,'$path/$id'));
    if (response.statusCode == 200) {
      print("deleted");
    }else{
      throw Exception("Field to delete the user");
    }
  }
}
