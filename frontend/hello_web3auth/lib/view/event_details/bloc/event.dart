import 'package:equatable/equatable.dart';

class CreateTicketEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class BuyTicketEvent extends CreateTicketEvent {
  final String eventID;

  BuyTicketEvent(this.eventID);

  @override
  List<Object?> get props => [eventID];
}
