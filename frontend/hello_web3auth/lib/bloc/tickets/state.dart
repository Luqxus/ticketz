import 'package:equatable/equatable.dart';
import 'package:hello_web3auth/models/ticket_model.dart';

class TicketState extends Equatable {
  @override
  List<Object?> get props => [];
}

class TicketInitialState extends TicketState {}

class TicketLoadingState extends TicketState {}

class GetTicketsSuccessState extends TicketState {
  final List<TicketModel> tickets;

  GetTicketsSuccessState(this.tickets);

  @override
  List<Object?> get props => [tickets];
}

class GetTicketSuccessState extends TicketState {
  final TicketModel ticket;

  GetTicketSuccessState(this.ticket);

  @override
  List<Object?> get props => [ticket];
}

class GetTicketsFailed extends TicketState {
  final String error;

  GetTicketsFailed(this.error);

  @override
  List<Object?> get props => [error];
}
