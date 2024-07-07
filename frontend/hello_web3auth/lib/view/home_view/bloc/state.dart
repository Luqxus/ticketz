import 'package:equatable/equatable.dart';
import 'package:hello_web3auth/models/event_model.dart';

class HomeViewState extends Equatable {
  // final bool isLoading;
  // final List<EventModel> events;
  // final bool isFailure;
  // final String errorMessage;
  final int tabIndex;

  const HomeViewState({
    // required this.errorMessage,
    // required this.events,
    // required this.isFailure,
    // required this.isLoading,
    required this.tabIndex,
  });

  HomeViewState copyWith({
    // errorMessage,
    // events,
    // isFailure,
    // isLoading,
    tabIndex,
  }) {
    return HomeViewState(
      tabIndex: tabIndex ?? this.tabIndex,
      // errorMessage: errorMessage ?? this.errorMessage,
      // events: events ?? this.events,
      // isFailure: isFailure ?? this.isFailure,
      // isLoading: isLoading ?? this.isLoading,
    );
  }

  @override
  List<Object?> get props => [
        // errorMessage,
        // events,
        // isFailure,
        // isLoading,
        tabIndex,
      ];
}
