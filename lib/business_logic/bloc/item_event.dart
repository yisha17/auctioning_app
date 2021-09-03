part of 'item_bloc.dart';

class ItemCreateEvent extends Equatable {
  const ItemCreateEvent();

  @override
  List<Object> get props => [];
}

class ItemEvent extends ItemCreateEvent {
  final String? itemName;
  final String? user;
  final int? increment;
  final int? minPrice;
  final String? closingDate;
  final String? closingTime;
  final List? image;
  ItemEvent({
    this.itemName,
    this.user,
    this.increment,
    this.minPrice,
    this.closingDate,
    this.closingTime,
    this.image,
  });
}

class CalanderEvent extends ItemCreateEvent {}

class CameraEvent extends ItemCreateEvent {}

class OnSubmitEvent extends ItemCreateEvent {}
