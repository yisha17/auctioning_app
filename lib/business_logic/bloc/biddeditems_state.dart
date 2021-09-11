part of 'biddeditems_bloc.dart';

abstract class BiddeditemsState extends Equatable {
  const BiddeditemsState();
  
  @override
  List<Object> get props => [];
}


class ItemSuccess extends BiddeditemsState {
  final List<ProcessModel> items;

  ItemSuccess([this.items = const []]);

  @override
  List<Object> get props => [items];
}

class LoadingState extends BiddeditemsState {}
class UserFailure extends BiddeditemsState {}