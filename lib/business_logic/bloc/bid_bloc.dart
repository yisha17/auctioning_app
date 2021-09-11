import 'dart:async';

import 'package:bidding_app/business_logic/bloc/alluser_bloc.dart';
import 'package:bidding_app/data/dataproviders/processDataProvider.dart';
import 'package:bidding_app/data/models/process.dart';
import 'package:bidding_app/data/repositories/processRepository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'bid_event.dart';
part 'bid_state.dart';

class BidBloc extends Bloc<BidEvent, BidState> {
  BidBloc() : super(BidState());
  ProcessRepository? processRepository;

  @override
  Stream<BidState> mapEventToState(
    BidEvent event,
  ) async* {
   if (event is BiddingEvent){
     try{
       yield LoadingState();
       await Future.delayed(Duration(seconds: 3));
       ProcessModel process = ProcessModel(
         bidder: event.bidder,
         item: event.item,
         price: event.price,
         image: event.image
       );
       print("eventes");
       print(event.bidder);
       print(event.price);
       print(event.image);
       print(event.item);
       final data = await ProcessDataProvider().bid(process);
       print("this s printing data");
       print(data);
       yield BidState(process: data);
     }catch(e){
       yield GetFailureState(e.toString());
     }
   }

  }
}
