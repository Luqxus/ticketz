import 'package:equatable/equatable.dart';

class CreateTicketState extends Equatable {
  @override
  List<Object?> get props => [];
}

class CreateTicketLoadingState extends CreateTicketState {}

class CreateTicketSuccessState extends CreateTicketState {}

class CreateTicketFailedState extends CreateTicketState {}

class CreateTicketInitialState extends CreateTicketState {}
