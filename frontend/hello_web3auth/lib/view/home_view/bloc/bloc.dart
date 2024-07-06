import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hello_web3auth/repository/event_respository.dart';
import 'package:hello_web3auth/view/home_view/bloc/event.dart';
import 'package:hello_web3auth/view/home_view/bloc/state.dart';

class HomeViewBloc extends Bloc<HomeViewEvent, HomeViewState> {
  final EventRespository eventRepository;
  HomeViewBloc({required this.eventRepository}) : super() {}
}
