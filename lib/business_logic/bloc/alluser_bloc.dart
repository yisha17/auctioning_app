import 'dart:async';


import 'package:bidding_app/data/dataproviders/UserdataProvider.dart';
import 'package:bidding_app/data/models/user_model.dart';
import 'package:bidding_app/data/repositories/userRepository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'alluser_event.dart';
part 'alluser_state.dart';

class AlluserBloc extends Bloc<AlluserEvent, AlluserState> {
  final UserRepository user;
  AlluserBloc({required this.user}) : super(LoadingState());

  @override
  Stream<AlluserState> mapEventToState(
    AlluserEvent event,
  ) async* {
    if (event is UserLoad) {
      yield LoadingState();
      try {
        final users = await UserDataProvider().fetchAllUsers();

        yield UserSuccess(users);
      } catch (_) {
        yield UserFailure();
      }
    }

    if (event is DeleteEvent) {
      yield LoadingState();
      try {
        final delete_user = await user.delete(event.id);
        final it = await user.fetchAllUsers();
        yield UserSuccess(it);
      } catch (_) {
        yield UserFailure();
      }
    }
  }
}
