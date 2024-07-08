import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hello_web3auth/bloc/events/bloc.dart';
import 'package:hello_web3auth/bloc/events/state.dart';
import 'package:hello_web3auth/models/event_model.dart';
import 'package:hello_web3auth/view/home_view/home/widgets/event_card.dart';

class HomeTab extends StatelessWidget {
  const HomeTab({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return BlocBuilder<EventsBloc, EventsState>(builder: (context, state) {
      if (state is FetchEventsSuccessState) {
        return HomeEventsView(events: state.events);
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

class HomeEventsView extends StatelessWidget {
  final List<EventModel> events;
  const HomeEventsView({super.key, required this.events});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    if (events.isEmpty) {
      return Center(
        child: SizedBox(
          width: size.width,
          height: size.height * 0.5,
          child: Image.asset("assets/no_event.png"),
        ),
      );
    } else {
      return ListView.builder(
        itemCount: events.length,
        shrinkWrap: true,
        itemBuilder: (context, int index) {
          return EventCard(
            event: events[index],
            size: size,
          );
        },
      );
    }
  }
}
