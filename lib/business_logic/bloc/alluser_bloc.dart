import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'alluser_event.dart';
part 'alluser_state.dart';

class AlluserBloc extends Bloc<AlluserEvent, AlluserState> {
  AlluserBloc() : super(AlluserInitial());

  @override
  Stream<AlluserState> mapEventToState(
    AlluserEvent event,
  ) async* {
    // TODO: implement mapEventToState
  }
}
