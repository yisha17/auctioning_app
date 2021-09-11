

import 'package:bidding_app/presentation/pages/LoginPage.dart';
import 'package:bidding_app/presentation/pages/SignupPage.dart';
import 'package:bidding_app/presentation/pages/bottomNavigationBar.dart';
import 'package:bidding_app/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_storage/get_storage.dart';

import 'business_logic/bloc/authentication_bloc.dart';

void main() async{
  await GetStorage.init();
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(new MyApp());
  });
}

class MyApp extends StatelessWidget {
  final authBloc = AuthenticationBloc();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      onGenerateRoute: RouteGenerator.generateRoute,
      debugShowCheckedModeBanner: false,
      title: 'Main App',
      home: BlocListener(
        bloc: authBloc,
        listener: (context, AuthenticationState state) {
          if (state is LoggedInState) {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => Pages()));
          } else {
            SignupPage();
          }
        },
        child: LoginPage(),
      ),
    );
  }
}
