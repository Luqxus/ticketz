import 'package:equatable/equatable.dart';
import 'package:hello_web3auth/models/event_model.dart';

class HomeViewState extends Equatable {
  final bool isLoading;
  final List<EventModel> events;
  final bool isFailure;
  final String errorMessage;

  const HomeViewState({
    required this.errorMessage,
    required this.events,
    required this.isFailure,
    required this.isLoading,
  });

  HomeViewState copyWith({
    errorMessage,
    events,
    isFailure,
    isLoading,
  }) {
    return HomeViewState(
      errorMessage: errorMessage ?? this.errorMessage,
      events: events ?? this.events,
      isFailure: isFailure ?? this.isFailure,
      isLoading: isLoading ?? this.isLoading,
    );
  }

  @override
  List<Object?> get props => [
        errorMessage,
        events,
        isFailure,
        isLoading,
      ];
}
