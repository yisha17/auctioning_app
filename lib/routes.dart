import 'package:bidding_app/presentation/pages/LoginPage.dart';
import 'package:bidding_app/presentation/pages/bottomNavigationBar.dart';
import 'package:flutter/material.dart';

class RouteGenerator {
 static const String homePage = "/";
 static const String randomPage = "/random";

 static Route<dynamic> generateRoute(RouteSettings settings) {
   switch (settings.name) {
     case homePage:
       return MaterialPageRoute(builder: (_) => LoginPage());
     case randomPage:
       return MaterialPageRoute(builder: (_) => Pages());
     default:
       throw FormatException("Route was not found");
   }
 }
}
