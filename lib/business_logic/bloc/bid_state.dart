part of 'bid_bloc.dart';

class BidState {
  final ProcessModel? process;
  const BidState({this.process});
  
  factory BidState.initial() => BidState();
}

class GetFailureState extends BidState {
  final String error;

  GetFailureState(this.error);
}

class LoadingState extends BidState {}
