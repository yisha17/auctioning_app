
class ProcessModel {
  final String ?id;
  final String ?item;
  final String ?bidder;
  final String ?price;
  final String ?image;
  final bool ?winner;
  ProcessModel({
     this.id,
     this.item,
     this.bidder,
     this.price,
     this.image,
     this.winner,
  });

  factory ProcessModel.fromJSON(Map<String,dynamic> jsonMap){
    final result = ProcessModel(
      id:jsonMap['id'],
      item: jsonMap['item'],
      bidder: jsonMap['bidder'],
      price: jsonMap['price'],
      image: jsonMap['image'],
      winner: jsonMap['winner']
    );
    return result;
  }
}
