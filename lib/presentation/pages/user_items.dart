
import 'package:bidding_app/business_logic/bloc/allitem_bloc.dart';
import 'package:bidding_app/data/dataproviders/itemDataProvider.dart';
import 'package:bidding_app/data/repositories/itemRepository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_storage/get_storage.dart';

import '../../routes.dart';
import '../../sharedInfo.dart';
import 'item_create.dart';

class UserItems extends StatefulWidget {
  UserItemsState createState() => UserItemsState();
}

class UserItemsState extends State<UserItems> {
  final ItemRepository itemRepository = ItemRepository(ItemDataProvider());
  final sharedInfo = SharedInfo();
  final box = GetStorage();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pushNamed(RouteGenerator.randomPage);
          },
        ),
        title: Text('All Items'),
      ),
      body: RepositoryProvider.value(
        value: this.itemRepository,
        child: BlocProvider(
          create: (context) =>
              AllitemBloc(item: this.itemRepository)..add(ItemLoad()),
          child: BlocBuilder<AllitemBloc, AllitemState>(
            builder: (context, state) {
              if (state is UserFailure) {
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
              if (state is ItemSuccess) {
                final item = state.items;
                return Container(
                  child: ListView.builder(
                      itemCount: item.length,
                      itemBuilder: (_, index) {
                        if ('${item.elementAt(index).user}' ==
                            box.read('id')) {
                          return ListTile(
                            leading:
                                Image.network('${item.elementAt(index).image}'),
                            title: Text('${item.elementAt(index).itemName}'),
                            subtitle: Text('${item.elementAt(index).category}'),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                
                                IconButton(
                                  icon: Icon(Icons.edit),
                                  color: Colors.blue,
                                  onPressed: () {
                                    // WidgetsBinding.instance!
                                    //     .addPostFrameCallback(
                                    //         (_) => messageDialog(context));
                                  },
                                ),
                              ],
                            ),
                          );
                        }
                        return Container();
                      }),
                );
              }
              return Center(child: CircularProgressIndicator());
            },
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => CreateItemPage()));
          },
          child: Icon(Icons.add)),
    );
  }
}
