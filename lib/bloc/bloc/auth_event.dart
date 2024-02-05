part of 'auth_bloc.dart';

class AuthEvent {}

class AuthStateChangeEvent extends AuthEvent {
  final AuthStatus authStatus;
  AuthStateChangeEvent({required this.authStatus});
}

class AuthLogoutEvent extends AuthEvent {}

class AuthStatusChange extends AuthEvent {
  final AuthStatus authStatus;
  AuthStatusChange({required this.authStatus});
}
