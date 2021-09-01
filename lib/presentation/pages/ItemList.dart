import 'dart:io';

import 'package:auction_real/business_logic/bloc/listitem_bloc.dart';
import 'package:auction_real/data/dataproviders/itemDataProvider.dart';
import 'package:auction_real/data/repositories/itemRepository.dart';
import 'package:auction_real/presentation/pages/BiddingPage.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
