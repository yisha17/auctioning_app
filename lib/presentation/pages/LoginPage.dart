


import 'package:bidding_app/business_logic/bloc/authentication_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_storage/get_storage.dart';

import '../../sharedInfo.dart';

import 'SignupPage.dart';
import 'administrator.dart';
import 'bottomNavigationBar.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key? key}) : super(key: key);
  @override
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  var _formKey = GlobalKey<FormState>();
  final textControllerEmail = TextEditingController(),
      textControllerPassword = TextEditingController();

  bool bCheckEmail = false;
  bool bCheckPassword = false;

  final authBloc = AuthenticationBloc();
  final sharedInfo = SharedInfo();
  final box = GetStorage();

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
        validator: validatePassword,
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
        validator: validateEmail,
        keyboardType: TextInputType.emailAddress,
      ),
    );
  }

  Widget buildSigninButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: ElevatedButton(
        onPressed: () {
          print(textControllerEmail.text);
          print(textControllerPassword.text);
          authBloc.onLogin(
              textControllerEmail.text, textControllerPassword.text);
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
            'Sign in',
            style: TextStyle(color: Colors.white, fontSize: 25),
          ),
        ),
      ),
    );
  }

  String? validatePassword(String? value) {
    if (value!.length < 6) {
      bCheckPassword = false;
      return "Must be more than 3 character!";
    } else {
      bCheckPassword = true;
      return '';
    }
  }

  String? validateEmail(String? value) {
    String regexEmailPattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(regexEmailPattern);
    if (!regex.hasMatch(value!)) {
      bCheckEmail = false;
      return "Not a valid email address, Should be your@email.com!";
    } else {
      bCheckEmail = true;
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener(
      bloc: authBloc,
      listener: (context, AuthenticationState state) {
        if (state.user != null && state is AuthenticationState) {
          Navigator.of(context, rootNavigator: true).pop();
          box.write('id', state.user!.id);
          print(box.read('id'));
          sharedInfo.sharedLoginSave(state.user!);
          print(state.user!.name);
          box.write('name', state.user!.name);
          box.write('email', state.user!.email);
          box.write('password', state.user!.password);
          box.write('administrator', state.user!.administrator);
          print(box.read('email'));
          print(box.read('name'));
          print(box.read('password'));

          box.read('administrator')
              ? Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => Administrator()))
              : Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => Pages()));
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
                        'Sign in',
                        textAlign: TextAlign.start,
                        style: TextStyle(
                            color: Color(0xFF42A5F5),
                            fontSize: 40,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(
                      height: 55,
                    ),
                    Container(
                      child: Text(
                        'Welcome!',
                        style: TextStyle(
                            fontSize: 45,
                            color: Color(0xFF42A5F5),
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                    SizedBox(
                      height: 35,
                    ),
                    buildEmailContainer(),
                    SizedBox(
                      height: 35,
                    ),
                    buildPasswordContainer(),
                    SizedBox(
                      height: 35,
                    ),
                    buildSigninButton(),
                    SizedBox(
                      height: 35,
                    ),
                    Container(
                      alignment: Alignment.center,
                      child: Text(
                        'OR',
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                    SizedBox(
                      height: 35,
                    ),
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: 'Already have an Account?',
                                  style: TextStyle(
                                    color: Colors.black38,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => SignupPage()));
                            },
                            child: Text(
                              ' Sign in',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            style: TextButton.styleFrom(
                              primary: Colors.lightBlue,
                            ),
                          )
                        ],
                      ),
                    )
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
