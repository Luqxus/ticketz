import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hello_web3auth/bloc/bookmark/bloc.dart';
import 'package:hello_web3auth/bloc/bookmark/event.dart';
import 'package:hello_web3auth/bloc/bookmark/state.dart';
import 'package:hello_web3auth/models/event_model.dart';
import 'package:hello_web3auth/view/create_event/bloc/state.dart';
import 'package:hello_web3auth/view/event_details/bloc/bloc.dart';
import 'package:hello_web3auth/view/event_details/bloc/state.dart';
import 'package:hello_web3auth/view/event_details/event_details_screen.dart';

class EventCard extends StatelessWidget {
  const EventCard({
    super.key,
    required this.event,
    required this.size,
  });

  final EventModel event;

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => BlocProvider<CreateTicketBloc>(
                create: (context) => CreateTicketBloc(),
                child: EventDetailsScreen(event: event),
              ),
            ),
          );
        },
        child: Container(
          height: 250,
          width: size.width,
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.0),
            image: DecorationImage(
              image: NetworkImage(event.imageUrl),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  BlocProvider(
                    create: (context) => BookmarkBloc()
                      ..add(
                        SetInitialStateEvent(event.isBookmarked),
                      ),
                    child: BookmarkButton(
                      eventID: event.eventId,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(12.0),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(1),
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                event.title,
                                style: const TextStyle(
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                              Text(
                                event.location.venue,
                                style: const TextStyle(
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey,
                                ),
                              ),
                              const SizedBox(
                                height: 4.0,
                              ),
                              Text(
                                '${event.location.country} - ${event.location.city}',
                                style: const TextStyle(color: Colors.grey),
                              ),
                            ],
                          ),
                          Container(
                            height: 70.0,
                            decoration: BoxDecoration(
                              color: Theme.of(context)
                                  .colorScheme
                                  .secondaryContainer,
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                const Text(
                                  'Feb',
                                  style: TextStyle(
                                    color: Colors.black,
                                  ),
                                ),
                                const SizedBox(
                                  height: 4.0,
                                ),
                                Text(
                                  '12',
                                  style: TextStyle(
                                    color:
                                        Theme.of(context).colorScheme.secondary,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 16.0,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class BookmarkButton extends StatelessWidget {
  const BookmarkButton({super.key, required this.eventID});

  final String eventID;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: Colors.white.withOpacity(0.8),
      child: InkWell(
        onTap: () {
          BlocProvider.of<BookmarkBloc>(context)
              .add(ToggleBookmarkEvent(eventID));
        },
        child: BlocBuilder<BookmarkBloc, BookmarkState>(
          builder: (context, state) {
            if (state.bookmarked) {
              return Icon(
                CupertinoIcons.bookmark_fill,
                color: Theme.of(context).primaryColor,
              );
            }
            return const Icon(
              CupertinoIcons.bookmark,
              color: Colors.black,
            );
          },
        ),
      ),
    );
  }
}
