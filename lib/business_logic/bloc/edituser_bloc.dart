import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'edituser_event.dart';
part 'edituser_state.dart';

class EdituserBloc extends Bloc<EdituserEvent, EdituserState> {
  EdituserBloc() : super(EdituserInitial());

  @override
  Stream<EdituserState> mapEventToState(
    EdituserEvent event,
  ) async* {
    // TODO: implement mapEventToState
  }
}
