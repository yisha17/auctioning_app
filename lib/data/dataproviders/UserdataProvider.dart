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