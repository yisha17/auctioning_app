import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'listitem_event.dart';
part 'listitem_state.dart';

class ListitemBloc extends Bloc<ListitemEvent, ListitemState> {
  ListitemBloc() : super(ListitemInitial());

  @override
  Stream<ListitemState> mapEventToState(
    ListitemEvent event,
  ) async* {
    // TODO: implement mapEventToState
  }
}
