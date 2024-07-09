import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hello_web3auth/repository/ticket_repository.dart';
import 'package:hello_web3auth/service/secure_storage.dart';
import 'package:hello_web3auth/view/event_details/bloc/event.dart';
import 'package:hello_web3auth/view/event_details/bloc/state.dart';

class CreateTicketBloc extends Bloc<CreateTicketEvent, CreateTicketState> {
  final TicketRepository ticketRepository = TicketRepositoryImpl();

  CreateTicketBloc() : super(CreateTicketInitialState()) {
    on<BuyTicketEvent>(_buyTicket);
  }

  _buyTicket(BuyTicketEvent event, Emitter emit) async {
    try {
      emit(CreateTicketLoadingState());
      String? token = await SecureStorage().getToken();
      await ticketRepository.buyTicket(token!, event.eventID);
      emit(CreateTicketSuccessState());
    } catch (error) {
      emit(CreateTicketFailedState());
    }
  }
}
