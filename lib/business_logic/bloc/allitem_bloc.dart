import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:auction_real/data/models/item_model.dart';
import 'package:auction_real/data/repositories/itemRepository.dart';
part 'allitem_event.dart';
part 'allitem_state.dart';

class AllitemBloc extends Bloc<AllitemEvent, AllitemState> {
  AllitemBloc() : super(AllitemInitial());

  @override
  Stream<AllitemState> mapEventToState(
    AllitemEvent event,
  ) async* {
    // TODO: implement mapEventToState
  }
}
