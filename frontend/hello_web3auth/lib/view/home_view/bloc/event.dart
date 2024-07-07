import 'package:equatable/equatable.dart';

class HomeViewEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class ToggleTabEvent extends HomeViewEvent {
  final int index;

  ToggleTabEvent(this.index);

  @override
  List<Object?> get props => [index];
}
