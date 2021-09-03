import 'package:auction_real/data/models/item_model.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'item_state.dart';
part 'item_event.dart';
class ItemCreateBloc extends Bloc<ItemCreateEvent,ItemCreateState>{
  ItemCreateBloc(this.context):super(ItemCreateState());
  BuildContext context;
  void onCreate(
    String itemName,
    String user,
    int increment,
    int minPrice,
    String closingDate,
    String closingTime,
    final List image){
      add(ItemEvent(itemName:itemName,
      user: user,
      increment: increment,
      minPrice: minPrice,
      closingDate: closingDate,
      closingTime: closingTime,
      image: image,));
    }  

  @override
  Stream<ItemCreateState> mapEventToState(ItemCreateEvent event) async* {
     if(event is ItemEvent){
       try{
         yield LoadingState();
         await Future.delayed(Duration(seconds: 2));
         ItemModel item= ItemModel(
           itemName: event.itemName?.trim().toString(),
           user: "",
           increment:event.increment?.trim().toString());
       }
     }
  }
}