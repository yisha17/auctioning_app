
import 'package:bidding_app/business_logic/bloc/allitem_bloc.dart';
import 'package:bidding_app/data/dataproviders/itemDataProvider.dart';
import 'package:bidding_app/data/repositories/itemRepository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AllItems extends StatelessWidget {
  final ItemRepository itemRepository = ItemRepository(ItemDataProvider());

  // void messageDialog(BuildContext context, {String? id}) {
  //   showDialog(
  //       context: context,
  //       barrierDismissible: false,
  //       builder: (BuildContext context) {
  //         return BlocProvider.value(
  //           value: BlocProvider.of<AllitemBloc>(context),

  //           child: AlertDialog(
  //             title: Text("Are you sure you want to delete user?"),
  //             actions: [
  //               TextButton(
  //                 child: Text("YES"),
  //                 onPressed: () {
  //                   BlocProvider.of<AllitemBloc>(context).add(DeleteEvent(event.id));
  //                   Navigator.of(context, rootNavigator: true).pop();
  //                 },
  //               ),
  //               TextButton(
  //                 child: Text("NO"),
  //                 onPressed: () {
  //                   Navigator.of(context, rootNavigator: true).pop();
  //                 },
  //               ),
  //             ],
  //           ),
  //         );
  //       });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        
        title: Text('Your Items'),
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
                        return ListTile(
                            leading:
                                Image.network('${item.elementAt(index).image}'),
                            title: Text('${item.elementAt(index).itemName}'),
                            subtitle: Text('${item.elementAt(index).category}'),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  icon: Icon(Icons.delete),
                                  color: Colors.red,
                                  onPressed: () {
                                    BlocProvider.of<AllitemBloc>(context).add(
                                        DeleteEvent(
                                            '${item.elementAt(index).id}'));
                                  },
                                ),
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
                            ));
                      }),
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
