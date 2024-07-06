import 'package:equatable/equatable.dart';

class HomeViewEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class ToggleHomeTabEvent extends HomeViewEvent {}

class ToggleTicketsTabEvent extends HomeViewEvent {}

class ToggleProfileTabEvent extends HomeViewEvent {}

class ToggleBookmarkTabEvent extends HomeViewEvent {}
