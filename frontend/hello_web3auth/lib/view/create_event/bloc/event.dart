import 'package:equatable/equatable.dart';

class CreateEventEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class SetDateEvent extends CreateEventEvent {
  final DateTime date;

  SetDateEvent(this.date);

  @override
  List<Object?> get props => [date];
}

class SetEndDateEvent extends CreateEventEvent {
  final DateTime date;

  SetEndDateEvent(this.date);

  @override
  List<Object?> get props => [date];
}

class SetTitleEvent extends CreateEventEvent {
  final String title;

  SetTitleEvent(this.title);

  @override
  List<Object?> get props => [title];
}

class SetDescriptionEvent extends CreateEventEvent {
  final String description;

  SetDescriptionEvent(this.description);

  @override
  List<Object?> get props => [description];
}

class SetCityEvent extends CreateEventEvent {
  final String city;

  SetCityEvent(this.city);

  @override
  List<Object?> get props => [city];
}

class SetProvinceEvent extends CreateEventEvent {
  final String province;

  SetProvinceEvent(this.province);

  @override
  List<Object?> get props => [province];
}

class SetVenueEvent extends CreateEventEvent {
  final String venue;

  SetVenueEvent(this.venue);

  @override
  List<Object?> get props => [venue];
}

class SetCountryEvent extends CreateEventEvent {
  final String country;

  SetCountryEvent(this.country);

  @override
  List<Object?> get props => [country];
}

class SetImageUrlEvent extends CreateEventEvent {
  final String imageUrl;

  SetImageUrlEvent(this.imageUrl);

  @override
  List<Object?> get props => [imageUrl];
}

class SetTicketPriceEvent extends CreateEventEvent {
  final double price;

  SetTicketPriceEvent(this.price);

  @override
  List<Object?> get props => [price];
}

class CreateEventButtonPressed extends CreateEventEvent {}
