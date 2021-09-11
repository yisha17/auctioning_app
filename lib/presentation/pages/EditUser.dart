

import 'package:bidding_app/business_logic/bloc/edituser_bloc.dart';
import 'package:bidding_app/presentation/pages/profilePage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_storage/get_storage.dart';

import '../../sharedInfo.dart';

class EditUserPage extends StatefulWidget{
  @override
  EditUserState createState() {
    return EditUserState();
  }
}

class EditUserState extends State<EditUserPage>{
  final sharedInfo = SharedInfo();
  final editBloc = EdituserBloc();
  final box = GetStorage();
  var _formKey = GlobalKey<FormState>();
  final textControllerEmail = TextEditingController(),
      textControllerPassword = TextEditingController(),
      textControllerName = TextEditingController(),
      textControllerRepassword = TextEditingController();

  
    

  Widget buildUserNameContainer() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 30),
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.black26,
          width: 2,
        ),
        borderRadius: BorderRadius.circular(30),
      ),
      child: TextFormField(
        controller: textControllerName,
        decoration: InputDecoration(
          hintText: 'Username',
          contentPadding: EdgeInsets.only(bottom: 8),
          prefix: Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: Icon(
              Icons.account_circle,
              size: 24,
              color: Color(0xfff06292),
            ),
          ),
          border: InputBorder.none,
          focusedBorder: InputBorder.none,
        ),
        style: TextStyle(
          color: Colors.black,
          fontSize: 20,
        ),
        
      ),
    );
  }

  Widget buildEmailContainer() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 30),
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.black26,
          width: 2,
        ),
        borderRadius: BorderRadius.circular(30),
      ),
      child: TextFormField(
        controller: textControllerEmail,
        decoration: InputDecoration(
          hintText: 'Email',
          contentPadding: EdgeInsets.only(bottom: 8),
          prefix: Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: Icon(
              Icons.mail,
              size: 24,
              color: Color(0xfff06292),
            ),
          ),
          border: InputBorder.none,
          focusedBorder: InputBorder.none,
        ),
        style: TextStyle(
          color: Colors.black,
          fontSize: 20,
        ),
        
      ),
    );
  }

  Widget buildPasswordContainer() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 30),
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.black26,
          width: 2,
        ),
        borderRadius: BorderRadius.circular(30),
      ),
      child: TextFormField(
        controller: textControllerPassword,
        obscureText: true,
        decoration: InputDecoration(
          hintText: 'Password',
          contentPadding: EdgeInsets.only(bottom: 8),
          prefix: Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: Icon(
              Icons.lock,
              size: 24,
              color: Color(0xfff06292),
            ),
          ),
          border: InputBorder.none,
          focusedBorder: InputBorder.none,
        ),
        style: TextStyle(
          color: Colors.black,
          fontSize: 20,
        ),
        
      ),
    );
  }

  Widget buildRePasswordContainer() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 30),
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.black26,
          width: 2,
        ),
        borderRadius: BorderRadius.circular(30),
      ),
      child: TextFormField(
        controller: textControllerRepassword,
        obscureText: true,
        decoration: InputDecoration(
          hintText: 'Confirm Password',
          contentPadding: EdgeInsets.only(bottom: 8),
          prefix: Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: Icon(
              Icons.lock,
              size: 24,
              color: Color(0xfff06292),
            ),
          ),
          border: InputBorder.none,
          focusedBorder: InputBorder.none,
        ),
        style: TextStyle(
          color: Colors.black,
          fontSize: 20,
        ),
        
      ),
    );
  }

  Widget buildUserNameError() {
    return Container(
      alignment: Alignment.topLeft,
      padding: EdgeInsets.only(left: 65),
      child: Text(
        'Incorrect username',
        style: TextStyle(color: Colors.red, fontSize: 12),
        textAlign: TextAlign.start,
      ),
    );
  }    
  
  Widget buildSignUpButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: ElevatedButton(
        onPressed: () {
          editBloc.onEdit(textControllerName.text, textControllerEmail.text,
              textControllerPassword.text, textControllerRepassword.text);
              box.write('name', textControllerName.text);
              box.write('email', textControllerEmail.text);
              box.write('password', textControllerPassword.text);
        },
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(Color(0xfff06292)),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
          ),
        ),
        child: Container(
          alignment: Alignment.center,
          width: double.infinity,
          decoration: BoxDecoration(
              color: Color(0xfff06292),
              borderRadius: BorderRadius.circular(20)),
          child: Text(
            'Update',
            style: TextStyle(color: Colors.white, fontSize: 25),
          ),
        ),
      ),
    );
  }
  
  void loadingDialog(BuildContext context) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Loading..."),
            content: CircularProgressIndicator(
              strokeWidth: 6,
            ),
          );
        });
  }

  void messageDialog(BuildContext context, String message) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(message),
            actions: [
              ElevatedButton(
                child: Text("Ok"),
                onPressed: () {
                  Navigator.of(context, rootNavigator: true).pop();
                },
              ),
            ],
          );
        });
  }
  @override
  Widget build(BuildContext context) {
    return BlocListener(
      bloc: editBloc,
      listener: (context, EdituserState state) {
        if (state.user != null && state is EdituserState) {
          Navigator.of(context, rootNavigator: true).pop();
          sharedInfo.sharedLoginSave(state.user!);
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) =>ProfilePage()));
        } else if (state is LoadingState) {
          //show loading
          WidgetsBinding.instance!
              .addPostFrameCallback((_) => loadingDialog(context));
        } else if (state is GetFailureState) {
          Navigator.of(context, rootNavigator: true).pop();
          WidgetsBinding.instance!.addPostFrameCallback(
              (_) => messageDialog(context, "Upps... " + state.error));
        }
      },
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(15, 12, 15, 30),
            child: Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.only(left: 30),
                      alignment: Alignment.topLeft,
                      child: Text(
                        'Edit',
                        textAlign: TextAlign.start,
                        style: TextStyle(
                            color: Color(0xFF42A5F5),
                            fontSize: 40,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(
                      height: 35,
                    ),
                    buildUserNameContainer(),
                    SizedBox(
                      height: 20,
                    ),
                    buildEmailContainer(),
                    SizedBox(
                      height: 20,
                    ),
                    buildPasswordContainer(),
                    SizedBox(
                      height: 20,
                    ),
                    buildRePasswordContainer(),
                    SizedBox(
                      height: 45,
                    ),
                    buildSignUpButton(),
                    
                    
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

}