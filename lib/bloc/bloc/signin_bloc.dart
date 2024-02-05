import 'dart:async';
import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:mmlearning_admin/home/presentation/student/auth_repository.dart';

import '../../model/password.dart';
import '../../model/user_name.dart';

part 'signin_event.dart';
part 'signin_state.dart';

class SigninBloc extends Bloc<SigninEvent, SigninState> {
  final AuthenticationRepositoryApi authRepository;
  SigninBloc(this.authRepository) : super(const SigninState()) {
    on<UserNameChangeEvent>(_onUserNameChange);
    on<PasswordChangeEvent>(_onPasswordChange);
    on<SubmittedEvent>(_onSubmitted);
    on<SecurePasswordChange>(_onSecureChange);
  }

  FutureOr<void> _onUserNameChange(
      UserNameChangeEvent event, Emitter<SigninState> emit) {
    final userName = UserName.dirty(value: event.value);
    emit(state.copyWith(
        userName: userName,
        isValid: Formz.validate([userName, state.password])));
  }

  FutureOr<void> _onPasswordChange(
      PasswordChangeEvent event, Emitter<SigninState> emit) {
    final password = Password.dirty(value: event.value);
    emit(state.copyWith(
        password: password,
        isValid: Formz.validate([state.userName, password])));
  }

  FutureOr<void> _onSubmitted(
      SubmittedEvent event, Emitter<SigninState> emit) async {
    if (state.isValid) {
      emit(state.copyWith(status: FormzSubmissionStatus.inProgress));
      try {
        await authRepository.signIn(
            email: state.userName.value, password: state.password.value);
        emit(state.copyWith(status: FormzSubmissionStatus.success));
      } catch (e) {
        log("Signin Error: $e");
        emit(state.copyWith(status: FormzSubmissionStatus.failure));
      }
    } else {
      emit(state.copyWith(status: FormzSubmissionStatus.failure));
    }
  }

  FutureOr<void> _onSecureChange(
      SecurePasswordChange event, Emitter<SigninState> emit) {
    emit(state.copyWith(isSecure: !state.isSecure));
  }
}
