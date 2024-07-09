import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hello_web3auth/bloc/events/bloc.dart';
import 'package:hello_web3auth/bloc/events/state.dart';
import 'package:hello_web3auth/models/event_model.dart';
import 'package:hello_web3auth/view/home_view/home/widgets/event_card.dart';

class BookmarksTab extends StatelessWidget {
  const BookmarksTab({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return BlocBuilder<EventsBloc, EventsState>(builder: (context, state) {
      if (state is FetchEventsSuccessState) {
        return BookmarkHomeView(events: state.events);
      } else if (state is FetchEventsFailureState) {
        return Center(
          child: SizedBox(
            width: size.width,
            height: size.height * 0.5,
            child: Image.asset("assets/internalservererror.png"),
          ),
        );
      } else {
        return const Center(
          child: CircularProgressIndicator(),
        );
      }
    });
  }
}

class BookmarkHomeView extends StatelessWidget {
  final List<EventModel> events;
  const BookmarkHomeView({super.key, required this.events});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    List<EventModel> bookmarkedEvents = [];

    for (EventModel event in events) {
      if (event.isBookmarked) {
        bookmarkedEvents.add(event);
      }
    }

    if (bookmarkedEvents.isEmpty) {
      return Center(
        child: SizedBox(
          width: size.width,
          height: size.height * 0.5,
          child: Image.asset("assets/no_event.png"),
        ),
      );
    } else {
      return ListView.builder(
        itemCount: bookmarkedEvents.length,
        shrinkWrap: true,
        itemBuilder: (context, int index) {
          if (bookmarkedEvents[index].isBookmarked) {
            return EventCard(
              event: bookmarkedEvents[index],
              size: size,
            );
          }

          return const SizedBox();
        },
      );
    }
  }
}
