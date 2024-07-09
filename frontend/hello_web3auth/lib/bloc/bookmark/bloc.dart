import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hello_web3auth/bloc/bookmark/event.dart';
import 'package:hello_web3auth/bloc/bookmark/state.dart';
import 'package:hello_web3auth/repository/event_repository.dart';

class BookmarkBloc extends Bloc<BookmarkEvent, BookmarkState> {
  final EventRepository eventRepository = EventRepositoryImpl();
  BookmarkBloc() : super(BookmarkState(bookmarked: false)) {
    on<ToggleBookmarkEvent>(_bookmarkEvent);
    on<SetInitialStateEvent>(_setInitialState);
  }

  _setInitialState(SetInitialStateEvent event, Emitter emit) {
    emit(state.copyWith(bookmarked: event.bookmarked));
  }

  _bookmarkEvent(ToggleBookmarkEvent event, Emitter emit) async {
    try {
      emit(state.copyWith(bookmarked: !state.bookmarked));
      await eventRepository.bookmarkEvent(eventID: event.eventID);
    } catch (error) {
      print(error.toString());
      emit(state.copyWith(bookmarked: !state.bookmarked));
    }
  }
}
