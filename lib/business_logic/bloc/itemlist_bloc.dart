import 'dart:async';


import 'package:bidding_app/data/models/item_model.dart';
import 'package:bidding_app/data/repositories/itemRepository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'itemlist_event.dart';
part 'itemlist_state.dart';

class ListitemBloc extends Bloc<ListitemEvent, ListitemState> {
  final ItemRepository item;
  ListitemBloc({required this.item}) : super(CourseLoading());

  @override
  Stream<ListitemState> mapEventToState(
    ListitemEvent event,
  ) async* {
    if (event is CourseLoad) {
      yield CourseLoading();
      try {
        final items = await item.fetchCategory(event.category);
        print(items);
        yield CourseOperationSuccess(items!);
      } catch (_) {
        yield CourseOperationFailure();
      }
    }
  }
}