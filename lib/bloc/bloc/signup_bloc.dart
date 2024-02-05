import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:mmlearning_admin/home/presentation/student/auth_repository.dart';

import '../../enum_class.dart';
import '../../model/email.dart';
import '../../model/first_name.dart';
import '../../model/last_name.dart';
import '../../model/password.dart';
import '../../model/user_name.dart';

part 'signup_event.dart';
part 'signup_state.dart';

class SignupBloc extends Bloc<SignupEvent, SignupState> {
  final AuthenticationRepositoryApi authRepo;
  SignupBloc(this.authRepo) : super(const SignupState()) {
    on<UserNameChangeEvent>(_onUserNameChange);
    on<EmailChangeEvent>(_onEmailChange);
    on<FirstNameChangeEvent>(_onFirstNameChange);
    on<LastNameChangeEvent>(_onLastNameChange);
    on<PasswordChangeEvent>(_onPasswordChange);
    on<SubmittedEvent>(_onSubmitted);
  }

  FutureOr<void> _onUserNameChange(
      UserNameChangeEvent event, Emitter<SignupState> emit) {
    final userName = UserName.dirty(value: event.value);
    emit(state.copyWith(
        //userName: userName,
        isValid: Formz.validate([
      userName,
      state.email,
      state.password,
      state.firstName,
      state.lastName,
    ])));
  }

  FutureOr<void> _onEmailChange(
      EmailChangeEvent event, Emitter<SignupState> emit) {
    final email = Email.dirty(value: event.value);
    emit(state.copyWith(
        email: email,
        isValid: Formz.validate([
          //state.userName,
          email,
          state.password,
          state.firstName,
          state.lastName,
        ])));
  }

  FutureOr<void> _onFirstNameChange(
      FirstNameChangeEvent event, Emitter<SignupState> emit) {
    final firstName = FirstName.dirty(value: event.value);
    emit(state.copyWith(
        firstName: firstName,
        isValid: Formz.validate([
          // state.userName,
          state.email,
          state.password,
          firstName,
          state.lastName,
        ])));
  }

  FutureOr<void> _onLastNameChange(
      LastNameChangeEvent event, Emitter<SignupState> emit) {
    final lastName = LastName.dirty(value: event.value);
    emit(state.copyWith(
        lastName: lastName,
        isValid: Formz.validate([
          //state.userName,
          state.email,
          state.password,
          state.firstName,
          lastName,
        ])));
  }

  FutureOr<void> _onPasswordChange(
      PasswordChangeEvent event, Emitter<SignupState> emit) {
    final password = Password.dirty(value: event.value);
    emit(state.copyWith(
        password: password,
        isValid: Formz.validate([
          // state.userName,
          state.email,
          password,
          state.firstName,
          state.lastName,
        ])));
  }

  FutureOr<void> _onSubmitted(
      SubmittedEvent event, Emitter<SignupState> emit) async {
    if (state.isValid) {
      emit(state.copyWith(
          status: FormzSubmissionStatus.inProgress,
          failType: SignupFailType.empty));
      final response = await authRepo.signUp(
        userName: state.userName.value,
        //userName: state.email.value,
        email: state.email.value,
        firstName: state.firstName.value,
        lastName: state.lastName.value,
        password: state.password.value,
      );
      switch (response) {
        case SignUpStatus.success:
          emit(state.copyWith(status: FormzSubmissionStatus.success));
          break;
        case SignUpStatus.failed:
          emit(state.copyWith(status: FormzSubmissionStatus.failure));
          break;
        case SignUpStatus.userNameAlreadyExist:
          emit(state.copyWith(
              status: FormzSubmissionStatus.failure,
              failType: SignupFailType.userNameExist));
          break;
        default:
          emit(state.copyWith(status: FormzSubmissionStatus.failure));
      }
    } else {
      emit(state.copyWith(
        status: FormzSubmissionStatus.failure,
        isValid: Formz.validate([
          // state.userName,
          state.email,
          state.password,
          state.firstName,
          state.lastName,
        ]),
      ));
    }
  }
}
