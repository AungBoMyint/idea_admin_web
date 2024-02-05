import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mmlearning_admin/home/presentation/student/auth_repository.dart';

import '../../enum_class.dart';
import '../../model/student.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthenticationRepositoryApi authRepository;
  StreamSubscription? _streamSubscription;
  AuthBloc(this.authRepository)
      : super(const AuthState(
          authStatus: AuthStatus.unknown,
          student: null,
        )) {
    on<AuthStateChangeEvent>(_onAuthStateChange);
    on<AuthLogoutEvent>(_onAuthLogout);
    on<AuthStatusChange>(_onAuthStatusChange);
    if (!(_streamSubscription == null)) _streamSubscription?.cancel();
    _streamSubscription = authRepository.status.listen((event) {
      add(AuthStateChangeEvent(authStatus: event));
    });
  }

  FutureOr<void> _onAuthStateChange(
      AuthStateChangeEvent event, Emitter<AuthState> emit) async {
    switch (event.authStatus) {
      case AuthStatus.authenticated:
        //if authenticated,we need to fetch user
        final user = await authRepository.getUser();
        if (!(user == null)) {
          emit(state.copyWith(
              authStatus: AuthStatus.authenticated, student: user));
        }
        break;
      case AuthStatus.unauthenticated:
        emit(state.copyWith(authStatus: AuthStatus.unauthenticated));
        break;
      case AuthStatus.signUp:
        emit(state.copyWith(authStatus: AuthStatus.signUp));
        break;
      default:
        emit(state.copyWith(authStatus: AuthStatus.unauthenticated));
    }
  }

  FutureOr<void> _onAuthLogout(
      AuthLogoutEvent event, Emitter<AuthState> emit) async {
    await authRepository.logout();
    emit(state.copyWith(authStatus: AuthStatus.unauthenticated));
  }

  @override
  Future<void> close() {
    _streamSubscription?.cancel();
    return super.close();
  }

  FutureOr<void> _onAuthStatusChange(
      AuthStatusChange event, Emitter<AuthState> emit) {
    emit(state.copyWith(authStatus: event.authStatus));
  }
}
