import 'package:auction_real/presentation/pages/EditUser.dart';
import 'package:auction_real/presentation/pages/LoginPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../sharedInfo.dart';

class ProfilePage extends StatelessWidget {
  final sharedInfo = SharedInfo();
  SharedPreferences? sharedPreferences;
  final box = GetStorage();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      height: double.infinity,
      child: Stack(children: [
        Container(
          height: 150.0,
          decoration: new BoxDecoration(
            color: Color(0xFF42A5F5),
            boxShadow: [new BoxShadow(blurRadius: 40.0)],
            borderRadius: new BorderRadius.vertical(
              bottom: new Radius.elliptical(
                  MediaQuery.of(context).size.width, 100.0),
            ),
          ),
        ),
        Positioned(
          right: 10,
          top: MediaQuery.of(context).size.width * 0.09,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                icon: Icon(Icons.edit),
                color: Colors.white,
                onPressed: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => EditUserPage()));
                },
              ),
              SizedBox(
                width: 10,
              ),
              IconButton(
                icon: Icon(Icons.logout),
                color: Colors.white,
                onPressed: () async {
                  sharedPreferences = await SharedPreferences.getInstance();
                  await sharedPreferences?.clear();
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => LoginPage()));
                },
              ),
            ],
          ),
        ),
        Positioned(
          top: MediaQuery.of(context).size.width * 0.09,
          left: MediaQuery.of(context).size.width * 0.34,
          child: Text(
            'Profile',
            style: TextStyle(
                color: Colors.white,
                fontSize: MediaQuery.of(context).size.width * 0.1125,
                fontWeight: FontWeight.bold),
          ),
        ),
        Positioned(
          top: MediaQuery.of(context).size.width * 0.25,
          right: 0,
          left: 0,
          child: Container(
            alignment: Alignment.center,
            height: 90,
            width: MediaQuery.of(context).size.width * 0.225,
            decoration:
                BoxDecoration(shape: BoxShape.circle, color: Colors.white),
            child: Icon(
              Icons.person,
              color: Color(0xfff06292),
              size: 50,
            ),
          ),
        ),
        Positioned(
            top: MediaQuery.of(context).size.height * 0.3,
            child: Container(
              padding: EdgeInsets.only(left: 30),
              child: Column(
                children: [
                  Row(
                    children: [
                      Icon(Icons.account_box,
                          size: 30, color: Color(0xfff06292)),
                      Text(
                        box.read('name'),
                        style: TextStyle(fontSize: 30),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Icon(Icons.email, size: 30, color: Color(0xfff06292)),
                      Text(
                        box.read('email'),
                        style: TextStyle(fontSize: 30),
                      )
                    ],
                  )
                ],
              ),
            ))
      ]),
    ));
  }
}
