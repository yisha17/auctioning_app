part of 'item_bloc.dart';

class ItemCreateState {
  final ItemModel? item;

  ItemCreateState({this.item});
  factory ItemCreateState.initial() => ItemCreateState();
}

class GetFailureState extends ItemCreateState {
  final String error;

  GetFailureState(this.error);
}
class SuccessSaveItem extends ItemCreateState {}
class LoadingState extends ItemCreateState {}
