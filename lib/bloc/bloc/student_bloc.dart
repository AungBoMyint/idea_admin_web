import 'dart:async';
import 'dart:typed_data';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:formz/formz.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mmlearning_admin/api_path.dart';
import 'package:mmlearning_admin/core/data/common_repository.dart';
import 'package:mmlearning_admin/model/student_list_response.dart';

import '../../enum_class.dart';
import '../../form/form_string_required.dart';
import '../../model/form_image.dart';
import '../../model/student.dart';

part 'student_event.dart';
part 'student_state.dart';

class StudentBloc extends Bloc<StudentEvent, StudentState> {
  CommonRepositoryApi comRepo;
  StudentBloc(this.comRepo) : super(const StudentState()) {
    on<SearchStudent>(_onSearchStudent);
    on<AddStudent>(_onAddStudent);
    on<GetStartStudent>(_onGetStartStudent);
    on<GetMoreStudent>(_onGetMoreStudent);
    on<DeleteStudent>(_onDeleteStudent);
    on<ChangeAvatar>(_onChangeAvatar);
    on<ChangeUserName>(_onChangeUserName);
    on<ChangeEmail>(_onChangeEmail);
    on<ChangePassword>(_onChangePassword);
    on<ChangeFirstName>(_onChangeFirstName);
    on<ChangeLastName>(_onChangeLastName);
  }

  FutureOr<void> _onAddStudent(
      AddStudent event, Emitter<StudentState> emit) async {
    if (state.studentStatus != StudentStatus.adding && state.isValid) {
      emit(state.copyWith(studentStatus: StudentStatus.adding));
      final userResponse = await comRepo.postData(
        data: {
          "username": state.formUserName.value,
          "email": state.formEmail.value,
          "password": state.formPassword.value,
          "first_name": state.formFirstName.value,
          "last_name": state.formLastName.value,
        },
        path: signUpPath,
      );

      if (!(userResponse == null)) {
        //if success
        await comRepo.postFormData(
          data: {
            "avatar": MultipartFile.fromBytes(
                Uint8List.fromList(state.formAvatar.value),
                filename: "${DateTime.now().microsecondsSinceEpoch}.png"),
            "membership": "B",
            "points": 0,
            "user": userResponse["id"]
          },
          uploading: (v) {
            //Do Nothing
          },
          path: adminStudentPath,
        );
        //success
        emit(state.copyWith(
          studentStatus: StudentStatus.addingSuccess,
          //form refresh
          formAvatar: const FormImage.pure(),
          formEmail: const FormStringRequired.pure(),
          formFirstName: const FormStringRequired.pure(),
          formLastName: const FormStringRequired.pure(),
          formPassword: const FormStringRequired.pure(),
          formUserName: const FormStringRequired.pure(),
        ));
        add(GetStartStudent());
      } else {
        emit(state.copyWith(studentStatus: StudentStatus.addingFail));
      }
    }
  }

  FutureOr<void> _onGetStartStudent(
      GetStartStudent event, Emitter<StudentState> emit) async {
    emit(state.copyWith(status: RequestStatus.fetching));
    final response = await comRepo.getStudent(adminStudentPath);
    if (response.error == null) {
      //success
      emit(state.copyWith(
        status: RequestStatus.success,
        hasMore: response.next == null ? false : true,
        next: response.next,
        students: response.results,
      ));
    } else {
      //fail
      emit(state.copyWith(
        status: RequestStatus.error,
        error: response.error?.detail,
      ));
    }
  }

  FutureOr<void> _onGetMoreStudent(
      GetMoreStudent event, Emitter<StudentState> emit) async {
    if (state.hasMore) {
      //if has more
      emit(state.copyWith(status: RequestStatus.morefetching));
      final response = await comRepo.getStudent(state.next!);
      if (response.results?.isNotEmpty == true) {
        List<Student> previousList = List.from(state.students!);
        previousList.addAll(response.results!);
        emit(state.copyWith(
          status: RequestStatus.success,
          students: previousList,
          hasMore: response.next == null ? false : true,
          next: response.next,
        ));
      }
    }
  }

  FutureOr<void> _onDeleteStudent(
      DeleteStudent event, Emitter<StudentState> emit) async {
    emit(state.copyWith(studentStatus: StudentStatus.deleting));
    final response = await comRepo.delete("$adminStudentPath${event.id}/");
    if (response) {
      List<Student> students = List.from(state.students ?? []);
      students.removeWhere((element) => element.id == event.id);
      emit(state.copyWith(
        studentStatus: StudentStatus.deletingSuccess,
        students: students,
      ));
    } else {
      emit(state.copyWith(studentStatus: StudentStatus.deletingFail));
    }
  }

  FutureOr<void> _onChangeAvatar(
      ChangeAvatar event, Emitter<StudentState> emit) {
    final image = FormImage.dirty(value: event.value);
    emit(state.copyWith(
        formAvatar: image,
        isValid: Formz.validate([
          image,
          state.formEmail,
          state.formUserName,
          state.formPassword,
          state.formFirstName,
          state.formLastName,
        ])));
  }

  FutureOr<void> _onChangeUserName(
      ChangeUserName event, Emitter<StudentState> emit) {
    final userName = FormStringRequired.dirty(value: event.value);
    emit(state.copyWith(
        formUserName: userName,
        isValid: Formz.validate([
          state.formAvatar,
          state.formEmail,
          userName,
          state.formPassword,
          state.formFirstName,
          state.formLastName,
        ])));
  }

  FutureOr<void> _onChangeEmail(ChangeEmail event, Emitter<StudentState> emit) {
    final email = FormStringRequired.dirty(value: event.value);
    emit(state.copyWith(
        formEmail: email,
        isValid: Formz.validate([
          state.formAvatar,
          email,
          state.formUserName,
          state.formPassword,
          state.formFirstName,
          state.formLastName,
        ])));
  }

  FutureOr<void> _onChangePassword(
      ChangePassword event, Emitter<StudentState> emit) {
    final password = FormStringRequired.dirty(value: event.value);
    emit(state.copyWith(
        formPassword: password,
        isValid: Formz.validate([
          state.formAvatar,
          state.formEmail,
          state.formUserName,
          password,
          state.formFirstName,
          state.formLastName,
        ])));
  }

  FutureOr<void> _onChangeFirstName(
      ChangeFirstName event, Emitter<StudentState> emit) {
    final firstName = FormStringRequired.dirty(value: event.value);
    emit(state.copyWith(
        formFirstName: firstName,
        isValid: Formz.validate([
          state.formAvatar,
          state.formEmail,
          state.formUserName,
          state.formPassword,
          firstName,
          state.formLastName,
        ])));
  }

  FutureOr<void> _onChangeLastName(
      ChangeLastName event, Emitter<StudentState> emit) {
    final lastName = FormStringRequired.dirty(value: event.value);
    emit(state.copyWith(
        formLastName: lastName,
        isValid: Formz.validate([
          state.formAvatar,
          state.formEmail,
          state.formUserName,
          state.formPassword,
          state.formFirstName,
          lastName,
        ])));
  }

  FutureOr<void> _onSearchStudent(
      SearchStudent event, Emitter<StudentState> emit) async {
    if (state.studentStatus != StudentStatus.searching) {
      //search
      final response =
          await comRepo.search(path: adminStudentPath, data: event.value);
      if (!(response == null)) {
        final studentResponse = StudentListResponse.fromJson(response);
        //success
        emit(state.copyWith(
          studentStatus: StudentStatus.searchingSuccess,
          hasMore: studentResponse.next == null ? false : true,
          next: studentResponse.next,
          students: studentResponse.results,
        ));
      } else {
        //fail
        emit(state.copyWith(
          studentStatus: StudentStatus.searchingFail,
          error: "search discount error!",
        ));
      }
    }
  }
}
