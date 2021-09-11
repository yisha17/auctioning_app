part of 'allitem_bloc.dart';

abstract class AllitemState extends Equatable {
  const AllitemState();

  @override
  List<Object> get props => [];
}

class ItemSuccess extends AllitemState {
  final List<ItemModel> items;

  ItemSuccess([this.items = const []]);

  @override
  List<Object> get props => [items];
}

class LoadingState extends AllitemState {}

class UserFailure extends AllitemState {}
