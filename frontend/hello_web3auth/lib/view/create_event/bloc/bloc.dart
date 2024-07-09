import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hello_web3auth/repository/event_repository.dart';
import 'package:hello_web3auth/view/create_event/bloc/event.dart';
import 'package:hello_web3auth/view/create_event/bloc/state.dart';

class CreateEventBloc extends Bloc<CreateEventEvent, CreateEventState> {
  final EventRepository eventRepository;

  CreateEventBloc(this.eventRepository)
      : super(
          CreateEventState(
            city: "",
            country: "",
            description: "",
            endDate: DateTime.now(),
            eventDate: DateTime.now(),
            imageUrl: "",
            price: 0.0,
            province: "",
            title: "",
            venue: "",
            loading: false,
            failed: false,
            success: false,
            errorMessage: "",
            createButtonPressed: false,
          ),
        ) {
    on<SetCityEvent>(_setCity);
    on<SetCountryEvent>(_setCountry);
    on<SetDateEvent>(_setDate);
    on<SetDescriptionEvent>(_setDescription);
    on<SetEndDateEvent>(_setEndDate);
    on<SetImageUrlEvent>(_setImage);
    on<SetProvinceEvent>(_setProvince);
    on<SetTicketPriceEvent>(_setPrice);
    on<SetTitleEvent>(_setTitle);
    on<SetVenueEvent>(_setVenue);
    on<CreateEventButtonPressed>(_createEvent);
  }

  _setCity(SetCityEvent event, Emitter emit) {
    emit(state.copyWith(city: event.city));
  }

  _setCountry(SetCountryEvent event, Emitter emit) {
    emit(state.copyWith(country: event.country));
  }

  _setDate(SetDateEvent event, Emitter emit) {
    emit(state.copyWith(eventDate: event.date));
  }

  _setDescription(SetDescriptionEvent event, Emitter emit) {
    emit(state.copyWith(description: event.description));
  }

  _setEndDate(SetEndDateEvent event, Emitter emit) {
    emit(state.copyWith(endDate: event.date));
  }

  _setImage(SetImageUrlEvent event, Emitter emit) {
    emit(state.copyWith(imageUrl: event.imageUrl));
  }

  _setProvince(SetProvinceEvent event, Emitter emit) {
    emit(state.copyWith(province: event.province));
  }

  _setPrice(SetTicketPriceEvent event, Emitter emit) {
    emit(state.copyWith(price: event.price));
  }

  _setTitle(SetTitleEvent event, Emitter emit) {
    emit(state.copyWith(title: event.title));
  }

  _setVenue(SetVenueEvent event, Emitter emit) {
    emit(state.copyWith(venue: event.venue));
  }

  _createEvent(CreateEventButtonPressed event, Emitter emit) async {
    try {
      emit(state.copyWith(loading: true));
      await eventRepository.createEvent(
        city: state.city,
        country: state.country,
        description: state.description,
        eventDate: state.eventDate,
        imageUrl: state.imageUrl,
        province: state.province,
        title: state.title,
        price: state.price,
        venue: state.venue,
        endDate: state.endDate,
      );
      emit(state.copyWith(loading: false));
    } catch (error) {
      print(error.toString());
      emit(
        state.copyWith(
            loading: false, errorMessage: error.toString(), failed: true),
      );
    }
  }
}
