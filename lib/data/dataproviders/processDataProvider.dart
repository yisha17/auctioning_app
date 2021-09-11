import 'dart:convert';

import 'package:bidding_app/data/models/process.dart';
import 'package:http/http.dart' as http;

class ProcessDataProvider {
  static final String baseUrl = '127.0.0.1:5000';
  final String path = '/auction/v1/transaction';

  Future<ProcessModel> bid(ProcessModel process) async {
    final response = await http.post(Uri.http(baseUrl, path),
        headers: <String, String>{
          "Content-Type": "application/json;charset=UTF-8",
          "Access-Control-Allow-Origin": "*",
        },
        body: jsonEncode({
          "item": process.item,
          "bidder": process.bidder,
          "price": process.price,
          "winner": false,
          "image": process.image
        }));

    if (response.statusCode == 200) {
      return ProcessModel.fromJSON(jsonDecode(response.body));
    } else {
      throw Exception("can not bid");
    }
  }

  Future<List<ProcessModel>?> getBidderEvents(String bidder) async {
    final response = await http.get(Uri.http(baseUrl, '$path/$bidder'));
    if (response.statusCode == 200) {
      final process = jsonDecode(response.body) as List;

      try {
        List<ProcessModel> biddes =
            process.map((e) => ProcessModel.fromJSON(e)).toList();

        return biddes;
      } catch (err) {
        print(err);
      }
    } else {
      print("i dont get nothing");
      throw Exception("Could not fetch courses");
    }
  }

  Future<void> deleteItem(String id) async {
    final response = await http.delete(Uri.http(baseUrl, '$path/$id'));
    if (response.statusCode == 200) {
      print("deleted");
    } else {
      throw Exception("Field to delete the course");
    }
  }

  Future<ProcessModel> updatePrice(String id, ProcessModel process) async {
    final response = await http.post(Uri.http(baseUrl, path),
        headers: <String, String>{
          "Content-Type": "application/json;charset=UTF-8",
          "Access-Control-Allow-Origin": "*",
        },
        body: jsonEncode({
          "price": process.price,
        }));

    if (response.statusCode == 200) {
      return ProcessModel.fromJSON(jsonDecode(response.body));
    } else {
      throw Exception("can not bid");
    }
  }
}
