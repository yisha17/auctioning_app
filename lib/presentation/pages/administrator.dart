

import 'package:bidding_app/presentation/pages/allItems.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'LoginPage.dart';
import 'allUsers.dart';

class Administrator extends StatefulWidget{
  @override
 AdministratorState createState() => AdministratorState();
}


class AdministratorState extends State<Administrator>{
  int selectedIndex = 0;
PageController pageController = PageController();

var screen = [
AllItems(),
AllUser(),
LoginPage()
];
  void onTapped(int index) {
    setState(() => 
    selectedIndex = index
    );
    pageController.animateToPage(index,
        duration: Duration(milliseconds: 1000), curve: Curves.bounceInOut);

  }
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
       body:screen[selectedIndex] ,
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Users'),
          BottomNavigationBarItem(icon: Icon(Icons.sell), label: 'Items'),
          BottomNavigationBarItem(
              icon: Icon(Icons.account_box), label: 'Profile'),
        ],
        currentIndex: selectedIndex,
        selectedItemColor: Colors.blue,
        onTap: onTapped,
      ),
    );
  }

}