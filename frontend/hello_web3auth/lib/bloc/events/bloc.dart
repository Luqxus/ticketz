import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hello_web3auth/bloc/events/event.dart';
import 'package:hello_web3auth/bloc/events/state.dart';
import 'package:hello_web3auth/models/event_model.dart';
import 'package:hello_web3auth/repository/event_repository.dart';

class EventsBloc extends Bloc<EventsEvent, EventsState> {
  final EventRepository eventRepository;
  EventsBloc(this.eventRepository) : super(EventsInitialState()) {
    on<FetchEventsEvent>(_fetchEvents);
  }

  _fetchEvents(FetchEventsEvent event, Emitter emit) async {
    try {
      emit(EventsLoadingState());
      List<EventModel> events = await eventRepository.getEvents();
      emit(FetchEventsSuccessState(events));
    } catch (error) {
      print(error.toString());
      emit(FetchEventsFailureState());
    }
  }
}
