import 'dart:async';

import 'package:auction_real/data/models/item_model.dart';
import 'package:auction_real/data/repositories/itemRepository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'listitem_event.dart';
part 'listitem_state.dart';

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
