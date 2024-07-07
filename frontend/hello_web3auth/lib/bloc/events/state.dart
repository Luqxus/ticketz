import 'package:equatable/equatable.dart';
import 'package:hello_web3auth/models/event_model.dart';

class EventsState extends Equatable {
  @override
  List<Object?> get props => [];
}

class EventsInitialState extends EventsState {}

class FetchEventsSuccessState extends EventsState {
  final List<EventModel> events;

  FetchEventsSuccessState(this.events);

  @override
  List<Object?> get props => [events];
}

class FetchEventsFailureState extends EventsState {}

class EventsLoadingState extends EventsState {}
