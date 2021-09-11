part of 'allitem_bloc.dart';

abstract class AllitemEvent extends Equatable {
  const AllitemEvent();

  @override
  List<Object> get props => [];
}

class DeleteEvent extends AllitemEvent {
  final String id;
  DeleteEvent(this.id);
}

class ItemLoad extends AllitemEvent {
  const ItemLoad();

  @override
  List<Object> get props => [];
}
