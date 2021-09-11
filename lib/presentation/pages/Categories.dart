import 'package:bidding_app/data/repositories/itemRepository.dart';
import 'package:js/js.dart';


import 'package:flutter/material.dart';

import 'ItemList.dart';

class Categories extends StatefulWidget {
  CategoriesState createState() => CategoriesState();
}

class CategoriesState extends State<Categories> {
  late ItemRepository itemRepository;
  final List<IconData> icons = [
    Icons.home,
    Icons.tv,
    Icons.access_alarm,
    Icons.airport_shuttle,
    Icons.access_alarm,
    Icons.business_center
  ];
  final List<String> name = [
    'Apartment',
    'Appliance',
    'Clock',
    'Truck',
    'Artifact',
    'Bags'
  ];

  Widget buildGridElement(
    int index,
    context,
  ) {
    return ElevatedButton(
      onPressed: () async {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ItemList(category: name[index])));
      },
      style: ElevatedButton.styleFrom(
          primary: Colors.white,
          onPrimary: Colors.white,
          padding: EdgeInsets.all(0),
          shape: RoundedRectangleBorder(
              side: BorderSide.none, borderRadius: BorderRadius.circular(20))),
      child: Container(
        alignment: Alignment.center,
        height: MediaQuery.of(context).size.width * 0.3,
        width: MediaQuery.of(context).size.width * 0.3,
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [BoxShadow(blurRadius: 10)],
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          children: [
            Icon(
              icons[index],
              size: MediaQuery.of(context).size.width * 0.17,
              color: Color(0xfff06292),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              name[index],
              style: TextStyle(color: Colors.black, fontSize: 20),
            )
          ],
        ),
      ),
    );
  }

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
            top: 30,
            right: 0,
            child: IconButton(
              icon: Icon(Icons.logout),
              color: Colors.white,
              onPressed: () {},
            ),
          ),
          Positioned(
            top: 30,
            left: MediaQuery.of(context).size.width * 0.3,
            child: Text(
              'Categories',
              style: TextStyle(
                  fontSize: 35,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            ),
          ),
          Positioned(
            top: 100,
            child: Container(
              width: MediaQuery.of(context).size.width,
              alignment: Alignment.center,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      buildGridElement(0, context),
                      buildGridElement(1, context),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      buildGridElement(2, context),
                      buildGridElement(3, context),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      buildGridElement(4, context),
                      buildGridElement(5, context),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
