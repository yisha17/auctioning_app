import 'dart:convert';
import 'dart:io';

import 'package:auction_real/data/dataproviders/itemDataProvider.dart';
import 'package:auction_real/data/models/item_model.dart';



class ItemRepository{
  final ItemDataProvider dataProvider;
  static final String base_url = '127.0.0.1:5000';
  final String patht = '/auction/v1/seller';
 ItemRepository(
     this.dataProvider,
  );

 
  Future<List<ItemModel>?> fetchCategory(String category){
    print(category);
    return this.dataProvider.fetchCategories(category);
  }

  Future<List<ItemModel>?> fetchAllItems(){
    return this.dataProvider.fetchAllItems();
  }

  Future<List<ItemModel>?> fetchUserItems(String user){
    return this.dataProvider.fetchUserItems(user);
  }

  

  Future<void> delete(String id) async {
    this.dataProvider.deleteItem(id);
  }

  Future<ItemModel> createItem(ItemModel item) async{
    return this.dataProvider.createItem(item);
  }
  Future<ItemModel?> singleItem(String id) async{
    return this.dataProvider.singleItem(id);
  }

}