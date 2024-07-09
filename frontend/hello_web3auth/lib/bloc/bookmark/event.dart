import 'package:equatable/equatable.dart';

class BookmarkEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class ToggleBookmarkEvent extends BookmarkEvent {
  final String eventID;

  ToggleBookmarkEvent(this.eventID);

  @override
  List<Object?> get props => [eventID];
}

class SetInitialStateEvent extends BookmarkEvent {
  final bool bookmarked;

  SetInitialStateEvent(this.bookmarked);

  @override
  List<Object?> get props => [bookmarked];
}
