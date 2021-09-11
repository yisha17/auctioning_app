import 'dart:io';


import 'package:bidding_app/data/dataproviders/itemDataProvider.dart';
import 'package:bidding_app/data/models/item_model.dart';
import 'package:bidding_app/data/repositories/itemRepository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'item_state.dart';
part 'item_event.dart';

class ItemCreateBloc extends Bloc<ItemCreateEvent, ItemCreateState> {
  ItemCreateBloc(this.context) : super(ItemCreateState());
  BuildContext context;
  ItemRepository? itemRepository;

  void onCreate(
      String itemName,
      String user,
      String increment,
      String minPrice,
      String category,
      String closingDate,
      String closingTime,
      final String image) {
    add(ItemEvent(
      itemName: itemName,
      user: user,
      increment: increment,
      minPrice: minPrice,
      category: category,
      closingDate: closingDate,
      closingTime: closingTime,
      image: image,
    ));
  }

  @override
  Stream<ItemCreateState> mapEventToState(ItemCreateEvent event) async* {
    if (event is ItemEvent) {
      try {
        yield LoadingState();
        await Future.delayed(Duration(seconds: 2));
        ItemModel item;
        item = ItemModel(
          itemName: event.itemName?.trim().toString(),
          user: event.user?.trim().toString(),
          increment: event.increment?.toString(),
          minPrice: event.minPrice?.toString(),
          category: event.category?.trim().toString(),
          closingDate: event.closingDate?.trim().toString(),
          closingTime: event.closingTime?.trim().toString(),
          image: event.image
        );
        print(item.category);
        print(item.minPrice);
        print(item.itemName);
        print(item.category);
        print(item.closingDate);
        print(item.closingTime);
        print(item.user);
        print(event.image);
        final data = await ItemDataProvider().createItem(item);

        print("this is the data");
        // final data = await ItemDataProvider().create(item);
        yield SuccessSaveItem();
      } catch (e) {
        print(e);
        yield GetFailureState(e.toString());
      }
    }
  }
}
