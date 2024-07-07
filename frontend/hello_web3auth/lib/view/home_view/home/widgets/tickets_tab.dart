import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hello_web3auth/bloc/tickets/bloc.dart';
import 'package:hello_web3auth/bloc/tickets/state.dart';
import 'package:hello_web3auth/models/ticket_model.dart';
import 'package:hello_web3auth/view/home_view/home/widgets/ticket_card.dart';
import 'package:hello_web3auth/view/splash_screen.dart';
import 'package:hello_web3auth/view/ticket_details/ticket_details_screen.dart';

class TicketsTab extends StatelessWidget {
  const TicketsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TicketBloc, TicketState>(builder: (context, state) {
      if (state is TicketLoadingState) {
        return const SplashScreen();
      } else if (state is GetTicketsSuccessState) {
        return HomeTicketsView(tickets: state.tickets);
      } else if (state is GetTicketsFailed) {
        return Center(
          child: Text(state.error),
        );
      } else {
        return const SplashScreen();
      }
    });
  }
}

class HomeTicketsView extends StatelessWidget {
  const HomeTicketsView({super.key, required this.tickets});
  final List<TicketModel> tickets;

  @override
  Widget build(BuildContext context) {
    if (tickets.isEmpty) {
      return const Center(
        child: Text("Your Tickets will appear here"),
      );
    } else {
      return ListView.builder(
        itemCount: 20,
        shrinkWrap: true,
        itemBuilder: (context, int index) {
          return TicketCard(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => TicketDetailsScreen(
                    ticket: tickets[0],
                  ),
                ),
              );
            },
            ticket: tickets[0],
          );
        },
      );
    }
  }
}
