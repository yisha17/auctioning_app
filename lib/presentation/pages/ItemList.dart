import 'dart:io';


import 'package:bidding_app/business_logic/bloc/itemlist_bloc.dart';
import 'package:bidding_app/data/dataproviders/itemDataProvider.dart';
import 'package:bidding_app/data/repositories/itemRepository.dart';

import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'BiddingPage.dart';

class ItemList extends StatelessWidget {
  final String category;
  ItemList({required this.category});
  final ItemRepository itemRepository = ItemRepository(ItemDataProvider());
  Widget buildIndiviualItem() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 30),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Color(0xfff06292), width: 2),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            child: Image.network(
              'https://images.unsplash.com/photo-1597434824491-0932996e5823?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=750&q=80',
              height: 80,
              width: 100,
              fit: BoxFit.fill,
            ),
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Lavander Oil',
                style: TextStyle(color: Colors.black12, fontSize: 30),
              ),
              Text(
                '45,000 Birr',
                style: TextStyle(color: Colors.black12, fontSize: 20),
              )
            ],
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(onPressed: () {}, icon: Icon(Icons.forward)),
              Text(
                '2d:4h',
                style: TextStyle(color: Colors.black26),
              )
            ],
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RepositoryProvider.value(
        value: this.itemRepository,
        child: BlocProvider(
          create: (context) => ListitemBloc(item: this.itemRepository)
            ..add(CourseLoad(category)),
          child: BlocBuilder<ListitemBloc, ListitemState>(
            builder: (_, state) {
              if (state is CourseOperationFailure) {
                return Column(
                  children: [
                    Container(
                      alignment: Alignment.topLeft,
                      child: IconButton(
                        icon: Icon(Icons.arrow_back),
                        onPressed: () {
                          Navigator.of(context, rootNavigator: true).pop();
                        },
                      ),
                    ),
                    Center(
                      child: Text('could not get items'),
                    ),
                  ],
                );
              }
              if (state is CourseOperationSuccess) {
                final items = state.items;
                return Container(
                  height: double.infinity,
                  width: double.infinity,
                  child: Stack(
                    children: [
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
                        left: MediaQuery.of(context).size.width * 0.3,
                        child: Text(
                          category,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 35,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Positioned(
                        left: 20,
                        child: IconButton(
                            icon: Icon(Icons.arrow_back),
                            color: Colors.white,
                            onPressed: () {
                              Navigator.of(context, rootNavigator: true).pop();
                            }),
                      ),
                      Positioned(
                        top: 70,
                        height: 600,
                        width: MediaQuery.of(context).size.width,
                        child: ListView.builder(
                          itemCount: items.length,
                          itemBuilder: (_, index) {
                            return ListTile(
                              leading: Image.file(
                                  File('${items.elementAt(index).image}')),
                              title: Text('${items.elementAt(index).itemName}'),
                              subtitle:
                                  Text('${items.elementAt(index).category}'),
                              trailing: Text(
                                  '${items.elementAt(index).minPrice} Birr'),
                              onTap: () {
                                print('${items.elementAt(index).id}');
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => BiddingPage(
                                          id: '${items.elementAt(index).id}',
                                          itemName:'${items.elementAt(index).itemName}',
                                          increment:'${items.elementAt(index).increment}',
                                          minPrice:'${items.elementAt(index).minPrice} Birr',
                                          closingDate: '${items.elementAt(index).closingDate}',
                                          closingHour: '${items.elementAt(index).closingTime}',
                                          image:'${items.elementAt(index).image}' ,
                                        )));
                              },
                            );
                          },
                        ),
                      )
                    ],
                  ),
                );
              }
              return Center(child: CircularProgressIndicator());
            },
          ),
        ),
      ),
    );
  }
}
