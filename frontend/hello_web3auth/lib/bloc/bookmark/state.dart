import 'package:equatable/equatable.dart';

class BookmarkState extends Equatable {
  final bool bookmarked;

  BookmarkState({required this.bookmarked});

  BookmarkState copyWith({bookmarked}) {
    return BookmarkState(bookmarked: bookmarked ?? this.bookmarked);
  }

  @override
  List<Object?> get props => [bookmarked];
}
