import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'calendar_state.dart';

class CalendarCubit extends Cubit<CalendarState> {
  CalendarCubit() : super(CalendarInitial());
}
