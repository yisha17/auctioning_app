import 'dart:io';

import 'package:bidding_app/data/dataproviders/itemDataProvider.dart';
import 'package:bidding_app/data/repositories/itemRepository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';



class BiddingPage extends StatefulWidget {
  
  final String id;
  final String itemName;
  final String closingDate;
  final String closingHour;
  final String minPrice;
  final String increment;
  final String image;
  const BiddingPage({
    Key? key,
    required this.id,
    required this.itemName,
    required this.closingDate,
    required this.closingHour,
    required this.minPrice,
    required this.increment,
    required this.image,
  }) : super(key: key);
  
  
  @override
  BiddingPageState createState() {
    return BiddingPageState();
  }
}

class BiddingPageState extends State<BiddingPage>{
  
  
  final ItemRepository itemRepository = ItemRepository(ItemDataProvider());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Stack(
            children: [
              Container(
                  child: 
                       Image.file(
                          File(widget.image),
                          width: double.infinity,
                          height:
                              MediaQuery.of(context).size.height * 0.3,
                        )
                     ,
              )],
          ),
          Container(
            margin: EdgeInsets.fromLTRB(10, 5, 10, 0),
            padding: EdgeInsets.fromLTRB(10, 20, 10, 0),
            child: Column(
              children: [
                Text(
                  widget.itemName,
                  style: TextStyle(
                    color: Color(0xFF42A5F5),
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        Text(
                          "9",
                          style: TextStyle(
                              fontSize: 30, color: Colors.blue),
                        ),
                        Text(
                          "Bids",
                          style: TextStyle(
                              fontSize: 15, color: Colors.grey),
                        ),
                      ],
                    ),
                    Container(
                      width: 2,
                      height: 60,
                      color: Colors.grey,
                    ),
                    Column(
                      children: [
                        Text(
                          widget.increment,
                          style: TextStyle(
                              fontSize: 30, color: Colors.blue),
                        ),
                        Text(
                          "Increment",
                          style: TextStyle(
                              fontSize: 15, color: Colors.grey),
                        ),
                      ],
                    ),
                    Container(
                      width: 2,
                      height: 60,
                      color: Colors.grey,
                    ),
                    Column(
                      children: [
                        Text(
                          widget.minPrice,
                          style: TextStyle(
                              fontSize: 30, color: Colors.blue),
                        ),
                        Text(
                          "Min Price",
                          style: TextStyle(
                              fontSize: 15, color: Colors.grey),
                        ),
                      ],
                    ),
                  ],
                ),
                Divider(
                  thickness: 2,
                  indent: 10,
                  endIndent: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        Text(
                          widget.closingHour,
                          style: TextStyle(
                              fontSize: 30, color: Colors.blue),
                        ),
                        Text(
                          "Closing Time",
                          style: TextStyle(
                              fontSize: 15, color: Colors.grey),
                        ),
                      ],
                    ),
                    Container(
                      width: 2,
                      height: 60,
                      color: Colors.grey,
                    ),
                    Column(
                      children: [
                        Text(
                          widget.closingDate,
                          style: TextStyle(
                              fontSize: 30, color: Colors.blue),
                        ),
                        Text(
                          "Closing Date",
                          style: TextStyle(
                              fontSize: 15, color: Colors.grey),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                OutlinedButton(
                  child: Icon(Icons.add),
                  onPressed: () {},
                ),
                Text(widget.minPrice,
                    style:
                        TextStyle(fontSize: 30, color: Colors.green)),
                OutlinedButton(
                  child: Icon(Icons.minimize),
                  onPressed: () {},
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: ElevatedButton(
              onPressed: () {},
              child: Text('SET MAX BID'),
              style: ElevatedButton.styleFrom(
                  fixedSize:
                      Size(MediaQuery.of(context).size.width, 30),
                  primary: Colors.green),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: ElevatedButton(
              onPressed: () {},
              child: Text('BID NOW'),
              style: ElevatedButton.styleFrom(
                  fixedSize:
                      Size(MediaQuery.of(context).size.width, 30),
                  primary: Colors.red),
            ),
          ),
        ],
      ),
      
    );
  }
}
