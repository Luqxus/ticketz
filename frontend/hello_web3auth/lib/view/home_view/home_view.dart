import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:advanced_salomon_bottom_bar/advanced_salomon_bottom_bar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hello_web3auth/bloc/events/bloc.dart';
import 'package:hello_web3auth/bloc/events/event.dart';
import 'package:hello_web3auth/bloc/tickets/bloc.dart';
import 'package:hello_web3auth/bloc/tickets/event.dart';
import 'package:hello_web3auth/view/home_view/bloc/bloc.dart';
import 'package:hello_web3auth/view/home_view/bloc/event.dart';
import 'package:hello_web3auth/view/home_view/bloc/state.dart';
import 'package:hello_web3auth/view/home_view/home/widgets/bookmarks_tab.dart';
import 'package:hello_web3auth/view/home_view/home/widgets/home_tab.dart';
import 'package:hello_web3auth/view/home_view/home/widgets/tickets_tab.dart';
import 'package:hello_web3auth/view/home_view/profile/profile_tab.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      bottomNavigationBar: const BottomNavBar(),
      appBar: AppBar(
        title: const Text("Ticketz"),
      ),
      body: SizedBox(
        width: size.width,
        height: size.height,
        child: BlocListener<HomeViewBloc, HomeViewState>(
          listener: (context, state) {
            _pageController.animateToPage(
              state.tabIndex,
              duration: const Duration(milliseconds: 400),
              curve: Curves.easeIn,
            );
          },
          child: PageView(
            controller: _pageController,
            physics: const NeverScrollableScrollPhysics(),
            children: [
              // home page | events bloc provider
              MultiBlocProvider(providers: [
                BlocProvider.value(
                  value: BlocProvider.of<EventsBloc>(context)
                    ..add(FetchEventsEvent()),
                ),
                BlocProvider.value(
                  value: BlocProvider.of<TicketBloc>(context)
                    ..add(GetTicketsEvent()),
                ),
              ], child: const HomeTab()),

              // bookmark page | TODO: bookmark bloc provider
              BlocProvider.value(
                value: BlocProvider.of<EventsBloc>(context)
                  ..add(FetchEventsEvent()),
                child: const BookmarksTab(),
              ),

              // tickets page | tickets bloc provider
              BlocProvider.value(
                value: BlocProvider.of<TicketBloc>(context)
                  ..add(GetTicketsEvent()),
                child: const TicketsTab(),
              ),

              // profile page | TODO: user bloc provider
              const ProfileTab()
            ],
          ),
        ),
      ),
    );
  }
}

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeViewBloc, HomeViewState>(
      builder: (context, state) {
        return AdvancedSalomonBottomBar(
          currentIndex: state.tabIndex,
          onTap: (index) => _onTap(context, index),
          items: [
            // Home
            AdvancedSalomonBottomBarItem(
              icon: const Icon(CupertinoIcons.house_alt),
              title: const Text("Home"),
              selectedColor: Colors.purple,
            ),

            /// Bookmark
            AdvancedSalomonBottomBarItem(
              icon: const Icon(CupertinoIcons.bookmark),
              title: const Text("Bookmark"),
              selectedColor: Colors.pink,
            ),

            /// tickets
            AdvancedSalomonBottomBarItem(
              icon: const Icon(CupertinoIcons.tickets),
              title: const Text("Tickets"),
              selectedColor: Colors.orange,
            ),

            /// Profile
            AdvancedSalomonBottomBarItem(
              icon: const Icon(CupertinoIcons.person),
              title: const Text("Profile"),
              selectedColor: Colors.teal,
            ),
          ],
        );
      },
    );
  }

  _onTap(BuildContext context, index) {
    BlocProvider.of<HomeViewBloc>(context).add(ToggleTabEvent(index));
  }
}
