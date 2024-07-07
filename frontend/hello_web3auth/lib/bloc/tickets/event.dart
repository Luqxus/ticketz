import 'package:equatable/equatable.dart';

class TicketEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class BuyTicketEvent extends TicketEvent {
  final String eventId;

  BuyTicketEvent(this.eventId);

  @override
  List<Object?> get props => [eventId];
}

class GetTicketEvent extends TicketEvent {
  final String ticketId;

  GetTicketEvent(this.ticketId);

  @override
  List<Object?> get props => [];
}

class GetTicketsEvent extends TicketEvent {}
