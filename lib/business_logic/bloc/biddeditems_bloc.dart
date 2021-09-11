import 'dart:async';

import 'package:bidding_app/data/dataproviders/processDataProvider.dart';
import 'package:bidding_app/data/models/process.dart';
import 'package:bidding_app/data/repositories/processRepository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'biddeditems_event.dart';
part 'biddeditems_state.dart';

class BiddeditemsBloc extends Bloc<BiddeditemsEvent, BiddeditemsState> {

  BiddeditemsBloc() : super(LoadingState());

  @override
  Stream<BiddeditemsState> mapEventToState(
    BiddeditemsEvent event,
  ) async* {
    if (event is UserLoad) {
      yield LoadingState();
      try {
        final eve = await ProcessDataProvider().getBidderEvents(event.bidder);

        yield ItemSuccess(eve!);
      } catch (_) {
        yield UserFailure();
      }
    }
    if (event is DeleteEvent){
      yield LoadingState();
      final delete_user = await ProcessRepository(ProcessDataProvider()).delete(event.id);
        final it =await ProcessRepository(ProcessDataProvider()).getUserBiddes(event.id);
        yield ItemSuccess();
    }
  }
}
