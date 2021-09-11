import 'dart:io';

class ItemModel {
  final String? id;
  final String? itemName;
  final String? user;
  final String? increment;
  final String? minPrice;
  final String? closingDate;
  final String? closingTime;
  final String? category;
  final String? image;
  final bool? closed;

  ItemModel({
    this.id,
    this.itemName,
    this.user,
    this.increment,
    this.minPrice,
    this.closingDate,
    this.closingTime,
    this.category,
    this.image,
    this.closed
  });

  factory ItemModel.fromJSON(Map<String, dynamic> jsonMap) {
    final result = ItemModel(
        id: jsonMap['item_id'],
        itemName: jsonMap['item_name'],
        increment: jsonMap['increment'].toString(),
        minPrice: jsonMap['minimum_price'].toString(),
        user: jsonMap['user'],
        category: jsonMap['category'],
        closingDate: jsonMap['closing_date'],
        closingTime: jsonMap['closing_hour'],
        image: jsonMap['image'],
        closed: jsonMap['closed']);

    return result;
  }

// Map<String,dynamic> toJon(){
//  {

//  }
// }

}
