import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hello_web3auth/bloc/tickets/event.dart';
import 'package:hello_web3auth/bloc/tickets/state.dart';
import 'package:hello_web3auth/models/ticket_model.dart';
import 'package:hello_web3auth/repository/ticket_repository.dart';
import 'package:hello_web3auth/service/secure_storage.dart';

class TicketBloc extends Bloc<TicketEvent, TicketState> {
  final SecureStorage secureStorage;
  final TicketRepository ticketRepository;
  TicketBloc({required this.secureStorage, required this.ticketRepository})
      : super(TicketInitialState()) {
    on<GetTicketsEvent>(_getTickets);
    on<GetTicketEvent>(_getTicket);
  }

  _getTickets(GetTicketsEvent event, Emitter emit) async {
    try {
      emit(TicketLoadingState());

      final String? token = await secureStorage.getToken();
      List<TicketModel> tickets = await ticketRepository.getTickets(token!);
      emit(GetTicketsSuccessState(tickets));
    } catch (error) {
      emit(GetTicketsFailed("Internal Server Error"));
    }
  }

  _getTicket(GetTicketEvent event, Emitter emit) async {
    try {
      emit(TicketLoadingState());

      final String? token = await secureStorage.getToken();
      TicketModel ticket =
          await ticketRepository.getTicket(token!, event.ticketId);

      emit(GetTicketSuccessState(ticket));
    } catch (error) {
      emit(GetTicketsFailed(error.toString()));
    }
  }
}
