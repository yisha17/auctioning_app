import 'dart:convert';

import 'package:bidding_app/data/models/item_model.dart';

import 'package:http/http.dart' as http;

class ItemDataProvider {
  static final String base_url = '127.0.0.1:5000';
  final String path = '/auction/v1/seller';

  Future<List<ItemModel>?> fetchCategories(String category) async {
    final response = await http.get(Uri.http(base_url, '$path/$category'));

    if (response.statusCode == 200) {
      final items = jsonDecode(response.body) as List;
      print(items);
      try {
        List<ItemModel> itemsList =
            items.map((e) => ItemModel.fromJSON(e)).toList();

        return itemsList;
      } catch (err) {
        print(err);
      }
    } else {
      print("i dont get nothing");
      throw Exception("Could not fetch courses");
    }
  }

  Future<List<ItemModel>?> fetchUserItems(String user) async {
    final response = await http.get(Uri.http(base_url, '$path/$user'));

    if (response.statusCode == 200) {
      final items = jsonDecode(response.body) as List;
      try {
        List<ItemModel> itemsList =
            items.map((e) => ItemModel.fromJSON(e)).toList();

        return itemsList;
      } catch (err) {
        print(err);
      }
    } else {
      throw Exception("Could not fetch items");
    }
  }

  Future<List<ItemModel>?> fetchAllItems() async {
    final response = await http.get(Uri.http(base_url, '$path'));

    if (response.statusCode == 200) {
      final items = jsonDecode(response.body) as List;
      print(items);
      try {
        List<ItemModel> itemsList =
            items.map((e) => ItemModel.fromJSON(e)).toList();

        return itemsList;
      } catch (err) {
        print(err);
      }
    } else {
      print("i dont get nothing");
      throw Exception("Could not fetch courses");
    }
  }

  Future<ItemModel> createItem(ItemModel item) async {
    final response = await http.post(Uri.http(base_url, '/auction/v1/seller'),
        headers: <String, String>{
          "Content-Type": "application/json;charset=UTF-8",
          "Access-Control-Allow-Origin": "*",
        },
        body: jsonEncode({
          "item_name": item.itemName,
          "user": item.user,
          "closing_date": item.closingDate.toString(),
          "closing_hour": item.closingTime.toString(),
          "category": item.category,
          "minimum_price": item.minPrice,
          "increment": item.increment,
          "image": item.image
        }));

    if (response.statusCode == 200) {
      return ItemModel.fromJSON(jsonDecode(response.body));
    } else {
      throw Exception("can not create an item");
    }
  }

  Future<ItemModel> singleItem(String id) async {
    final response = await http.get(Uri.http(base_url, '$path/check/$id'));
    if (response.statusCode == 200) {
      return ItemModel.fromJSON(jsonDecode(response.body));
    } else {
      throw Exception("can't get user");
    }
  }

  Future<void> deleteItem(String id) async {
    final response = await http.delete(Uri.http(base_url, '$path/$id'));
    if (response.statusCode == 200) {
      print("deleted");
    } else {
      throw Exception("Field to delete the course");
    }
  }
}
