import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hello_web3auth/bloc/auth/event.dart';
import 'package:hello_web3auth/bloc/auth/state.dart';
import 'package:hello_web3auth/service/secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthenticationBloc extends Bloc<AuthEvent, AuthState> {
  final SecureStorage secureStorage;

  AuthenticationBloc({required this.secureStorage})
      : super(UninitializedState()) {
    on<AppStartedEvent>(_appStarted);
    on<LoggedIn>(_loggedIn);
    on<LoggedOut>(_loggedOut);
  }

  _appStarted(AppStartedEvent event, Emitter emit) async {
    _cleanIfFirstUseAfterUninstall();

    await _initStartup(emit);
  }

  _loggedIn(LoggedIn event, Emitter emit) async {
    emit(AuthLoadingState());
    await secureStorage.persistEmailAndToken(event.email, event.token);

    await _initStartup(emit);
  }

  _loggedOut(LoggedOut event, Emitter emit) async {
    emit(UnauthenticatedState());
    await secureStorage.deleteToken();
  }

  _initStartup(Emitter emit) async {
    final hasToken = await secureStorage.hasToken();

    if (!hasToken) {
      emit(UnauthenticatedState());
      return;
    }

    emit(AuthenticatedState());
  }

  Future<void> _cleanIfFirstUseAfterUninstall() async {
    final prefs = await SharedPreferences.getInstance();

    if (prefs.getBool('first_run') ?? true) {
      await secureStorage.deleteAll();
      await prefs.setBool('first_run', false);
    }
  }
}
