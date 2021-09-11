part of 'biddeditems_bloc.dart';

abstract class BiddeditemsEvent extends Equatable {
  const BiddeditemsEvent();

  @override
  List<Object> get props => [];
}


class DeleteEvent extends BiddeditemsEvent {
  final String id;
  DeleteEvent(this.id);
}

class EditEvent extends BiddeditemsEvent{
  final String id;
  EditEvent(this.id);
}

class UserLoad extends BiddeditemsEvent {
  final String bidder;
  const UserLoad(this.bidder);

  @override
  List<Object> get props => [];
}