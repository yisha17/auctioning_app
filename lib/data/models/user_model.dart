
class UserModel {
  final String ?id;
  final String ?name;
  final String ?email;
  final String ?password;
  final String ?re_password;
  final bool ?administrator;
  UserModel({
    this.id,
    this.name,
    this.email,
    this.password,
    this.re_password,
    this.administrator,
  });

  factory UserModel.fromJSON(Map<String,dynamic> jsonMap){
    final result = UserModel(
      id:jsonMap['id'],
      name: jsonMap['name'],
      email: jsonMap['email'],
      password: jsonMap['password'],
      re_password: jsonMap['re_password'],
      administrator: jsonMap['administrator']
    );
    return result;
  }
}
