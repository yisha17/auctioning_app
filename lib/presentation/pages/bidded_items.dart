import 'dart:io';

import 'package:bidding_app/business_logic/bloc/biddeditems_bloc.dart';
import 'package:bidding_app/data/dataproviders/processDataProvider.dart';
import 'package:bidding_app/data/repositories/processRepository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_storage/get_storage.dart';

class BiddedItems extends StatelessWidget {
  final box =  GetStorage();
  final ProcessRepository processRepository =
      ProcessRepository(ProcessDataProvider());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bidded Items'),
      ),
      body:  RepositoryProvider.value(
        value: this.processRepository,
        child: BlocProvider(
          create: (context) =>
              BiddeditemsBloc()..add(UserLoad(box.read('id'))),
          child: BlocBuilder<BiddeditemsBloc, BiddeditemsState>(
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
                      child: Text('could not get anything'),
                    ),
                  ],
                );
              }
              if (state is ItemSuccess) {
                final process = state.items;
                return Container(
                  child: ListView.builder(
                      itemCount: process.length,
                      itemBuilder: (_, index) {
                        return ListTile(
                            leading:
                                Image.file(File('${process.elementAt(index).image}')),
                            title: Text('${process.elementAt(index).item}'),
                            subtitle: Text('${process.elementAt(index).price}'),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  icon: Icon(Icons.delete),
                                  color: Colors.red,
                                  onPressed: () {
                                    BlocProvider.of<BiddeditemsBloc>(context).add(
                                        DeleteEvent(
                                            '${process.elementAt(index).id}'));
                                  },
                                ),
                                IconButton(
                                  icon: Icon(Icons.edit),
                                  color: Colors.blue,
                                  onPressed: () {
                                    
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
