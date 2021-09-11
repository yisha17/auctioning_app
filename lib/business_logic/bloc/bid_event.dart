part of 'bid_bloc.dart';

abstract class BidEvent extends Equatable {
  const BidEvent();

  @override
  List<Object> get props => [];
}


class BiddingEvent extends BidEvent {
  final String? bidder;
  final String? item;
  final String? price;
  final String? image;

  BiddingEvent({this.item, this.bidder, this.price, this.image});
}
