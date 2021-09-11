import 'dart:io';

import 'package:auction_real/business_logic/bloc/singleitem_bloc.dart';
import 'package:auction_real/data/dataproviders/itemDataProvider.dart';
import 'package:auction_real/data/repositories/itemRepository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// class BiddingPage extends StatefulWidget {

//   @override
//   BiddingPageState createState() {
//     return BiddingPageState();
//   }
//}

class BiddingPage extends StatelessWidget {
  final String id;
  BiddingPage({required this.id});
  final ItemRepository itemRepository = ItemRepository(ItemDataProvider());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => SingleitemBloc()..add(GetIdEvent(id: this.id)),
        child: BlocBuilder<SingleitemBloc, SingleitemState>(
          builder: (context, state) {
            if (state is LoadingItem) {
              return CircularProgressIndicator();
            }
            if (state is SingleitemState) {
              return Column(
                children: [
                  Stack(
                    children: [
                      Container(
                          child: state.item!.image! != null
                              ? Image.file(
                                  File(state.item!.image!),
                                  width: double.infinity,
                                  height:
                                      MediaQuery.of(context).size.height * 0.3,
                                )
                              : Icon(Icons.add)),
                    ],
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(10, 5, 10, 0),
                    padding: EdgeInsets.fromLTRB(10, 20, 10, 0),
                    child: Column(
                      children: [
                        Text(
                          "state.item!.itemName!",
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
                                  "state.item!.increment!",
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
                                  "state.item!.minPrice!",
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
                                  "state.item!.closingTime!",
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
                                  "state.item!.closingDate!",
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
                        Text("state.item!.minPrice!",
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
              );
            }

            return Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
    );
  }
}
