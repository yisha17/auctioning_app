part of 'listitem_bloc.dart';

abstract class ListitemState extends Equatable {
  const ListitemState();
  
  @override
  List<Object> get props => [];
}

class CourseLoading extends ListitemState {}

class CourseOperationSuccess extends ListitemState {
  final Iterable<ItemModel> items;

  CourseOperationSuccess([this.items = const []]);

  @override
  List<Object> get props => [items];
}

class CourseOperationFailure extends ListitemState {}