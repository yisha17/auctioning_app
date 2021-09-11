part of 'listitem_bloc.dart';

abstract class ListitemEvent extends Equatable {
  const ListitemEvent();

  @override
  List<Object> get props => [];
}


class CourseLoad extends ListitemEvent {
  final String category;
  const CourseLoad(this.category);

  @override
  List<Object> get props => [];
}
