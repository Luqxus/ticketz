import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:hello_web3auth/repository/event_respository.dart';
import 'package:hello_web3auth/view/home_view/bloc/event.dart';
import 'package:hello_web3auth/view/home_view/bloc/state.dart';

class HomeViewBloc extends Bloc<HomeViewEvent, HomeViewState> {
  HomeViewBloc()
      : super(const HomeViewState(
          // errorMessage: "",
          // events: [],
          // isFailure: false,
          // isLoading: false,
          tabIndex: 0,
        )) {
    on<ToggleTabEvent>(_toggleTab);
  }

  _toggleTab(ToggleTabEvent event, Emitter emit) {
    emit(state.copyWith(tabIndex: event.index));
  }
}
