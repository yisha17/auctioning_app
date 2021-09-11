


import 'package:bidding_app/data/dataproviders/processDataProvider.dart';
import 'package:bidding_app/data/models/process.dart';

class ProcessRepository{
  final ProcessDataProvider dataProvider;

  ProcessRepository(this.dataProvider);

  Future<List<ProcessModel>?> getUserBiddes(String bidder) {
    return this.dataProvider.getBidderEvents(bidder);
  }

  Future<ProcessModel> bid(ProcessModel process) {
    return this.dataProvider.bid(process);
  }

  Future<void> delete(String id) async{
    this.dataProvider.deleteItem(id);
  }

  
} 