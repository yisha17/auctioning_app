import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'itemlist_event.dart';
part 'itemlist_state.dart';

class ItemlistBloc extends Bloc<ItemlistEvent, ItemlistState> {
  ItemlistBloc() : super(ItemlistInitial());

  @override
  Stream<ItemlistState> mapEventToState(
    ItemlistEvent event,
  ) async* {
    // TODO: implement mapEventToState
  }
}
