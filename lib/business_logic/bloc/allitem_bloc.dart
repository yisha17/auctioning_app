import 'dart:async';

import 'package:auction_real/data/models/item_model.dart';
import 'package:auction_real/data/repositories/itemRepository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'allitem_event.dart';
part 'allitem_state.dart';

class AllitemBloc extends Bloc<AllitemEvent, AllitemState> {
  final ItemRepository item;
  AllitemBloc({required this.item}) : super(LoadingState());

  @override
  Stream<AllitemState> mapEventToState(
    AllitemEvent event,
  ) async* {
    if (event is ItemLoad) {
      yield LoadingState();
      try {
        final items = await item.fetchAllItems();

        yield ItemSuccess(items!);
      } catch (_) {
        yield UserFailure();
      }
    }
    if (event is DeleteEvent) {
      yield LoadingState();
      try {
        final items = await item.delete(event.id);
        final it = await item.fetchAllItems();
        yield ItemSuccess(it!);
      } catch (_) {
        yield UserFailure();
      }
    }
  }
}
