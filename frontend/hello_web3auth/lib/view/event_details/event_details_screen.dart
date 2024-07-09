import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hello_web3auth/models/event_model.dart';
import 'package:hello_web3auth/view/create_event/bloc/state.dart';
import 'package:hello_web3auth/view/event_details/bloc/bloc.dart';
import 'package:hello_web3auth/view/event_details/bloc/event.dart';
import 'package:hello_web3auth/view/event_details/bloc/state.dart';

class EventDetailsScreen extends StatelessWidget {
  const EventDetailsScreen({super.key, required this.event});

  final EventModel event;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlocListener<CreateTicketBloc, CreateTicketState>(
      listener: (context, state) {
        // Navigator.pop(context);
      },
      child: SafeArea(
        child: Scaffold(
          body: SizedBox(
            width: size.width,
            height: size.height,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  EventDetailsCard(
                    size: size,
                    title: event.title,
                    city: event.location.city,
                    country: event.location.country,
                    imageUrl: event.imageUrl,
                    price: event.price,
                    venue: event.location.venue,
                  ),
                  const Padding(
                    padding: EdgeInsets.only(
                        left: 20.0, top: 20.0, bottom: 4.0, right: 20.0),
                    child: Text(
                      "About this event",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 16.0),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 6.0, horizontal: 20.0),
                    child: Text(
                      event.description,
                      style: TextStyle(
                        color: Colors.grey[700],
                        fontSize: 14.0,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          bottomNavigationBar: SizedBox(
            height: 70,
            child: Padding(
              padding:
                  const EdgeInsets.only(bottom: 8.0, left: 32.0, right: 32.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Text(
                        "Total Price",
                        style: TextStyle(
                          fontSize: 14.0,
                          color: Colors.grey[500],
                        ),
                      ),
                      Text(
                        (event.price > 0) ? "R${event.price}" : "Free",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18.0,
                          color:
                              Theme.of(context).colorScheme.onPrimaryContainer,
                        ),
                      ),
                    ],
                  ),
                  TextButton(
                    style: TextButton.styleFrom(
                        backgroundColor:
                            Theme.of(context).colorScheme.onPrimaryContainer,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.0))),
                    onPressed: () {
                      BlocProvider.of<CreateTicketBloc>(context)
                          .add(BuyTicketEvent(event.eventId));
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 12.0, horizontal: 12.0),
                      child: BlocBuilder<CreateTicketBloc, CreateTicketState>(
                        builder: (context, state) {
                          if (state is CreateTicketLoadingState) {
                            return const CircularProgressIndicator();
                          } else if (state is CreateTicketFailedState) {
                            return const Icon(
                              Icons.error,
                              color: Colors.redAccent,
                            );
                          } else if (state is CreateTicketSuccessState) {
                            return Text(
                              'Done',
                              style: TextStyle(
                                color: Theme.of(context)
                                    .colorScheme
                                    .secondaryContainer,
                              ),
                            );
                          }
                          return Text(
                            'Buy Ticket',
                            style: TextStyle(
                              color: Theme.of(context)
                                  .colorScheme
                                  .secondaryContainer,
                            ),
                          );
                        },
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class EventDetailsCard extends StatelessWidget {
  const EventDetailsCard({
    super.key,
    required this.size,
    required this.title,
    required this.city,
    required this.country,
    required this.imageUrl,
    required this.price,
    required this.venue,
  });
  final double price;
  final String title;
  final String city;
  final String country;
  final String imageUrl;
  final String venue;

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 350.0,
        width: size.width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.0),
          image: DecorationImage(
            image: NetworkImage(imageUrl),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                padding: const EdgeInsets.all(12.0),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.85),
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    Text(
                      venue,
                      style: const TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('$country - $city'),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12.0),
                            color: Theme.of(context)
                                .colorScheme
                                .secondaryContainer,
                          ),
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            (price > 0) ? 'R $price' : "Free",
                            style: TextStyle(
                                fontWeight: FontWeight.w700,
                                color: Theme.of(context)
                                    .colorScheme
                                    .onPrimaryContainer,
                                fontSize: 16.0),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
