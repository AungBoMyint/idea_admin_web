import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:mmlearning_admin/api_path.dart';
import 'package:mmlearning_admin/core/data/common_repository.dart';
import 'package:mmlearning_admin/form/form_int.dart';
import 'package:mmlearning_admin/model/enrolled_student.dart';
import 'package:mmlearning_admin/model/enrollment_list_response.dart';

import '../../enum_class.dart';
import '../../model/enrollment.dart';

part 'enrollment_event.dart';
part 'enrollment_state.dart';

class EnrollmentBloc extends Bloc<EnrollmentEvent, EnrollmentState> {
  CommonRepositoryApi comRepo;
  EnrollmentBloc(this.comRepo) : super(const EnrollmentState()) {
    on<SearchEnrollment>(_onSearchEnrollment);
    on<GetStartEnrollment>(_onGetStartEnrollment);
    on<GetMoreEnrollment>(_onGetMoreEnrollment);
    on<AddEnrollment>(_onAddEnrollment);
    on<ChangeCourseId>(_onChangeCourseId);
    on<ChangeStudentId>(_onChangeStudentId);
  }

  FutureOr<void> _onGetStartEnrollment(
      GetStartEnrollment event, Emitter<EnrollmentState> emit) async {
    emit(state.copyWith(status: RequestStatus.fetching));
    final response = await comRepo.getEnrollment(enrollmentPath);
    if (response.error == null) {
      //success
      emit(state.copyWith(
        status: RequestStatus.success,
        hasMore: response.next == null ? false : true,
        next: response.next,
        enrollments: response.results,
      ));
    } else {
      //fail
      emit(state.copyWith(
        status: RequestStatus.error,
        error: response.error?.detail,
      ));
    }
  }

  FutureOr<void> _onGetMoreEnrollment(
      GetMoreEnrollment event, Emitter<EnrollmentState> emit) async {
    if (state.hasMore) {
      //if has more
      emit(state.copyWith(status: RequestStatus.morefetching));
      final response = await comRepo.getEnrollment(state.next!);
      if (response.results?.isNotEmpty == true) {
        List<Enrollment> previousList = List.from(state.enrollments!);
        previousList.addAll(response.results!);
        emit(state.copyWith(
          status: RequestStatus.success,
          enrollments: previousList,
          hasMore: response.next == null ? false : true,
          next: response.next,
        ));
      }
    }
  }

  FutureOr<void> _onAddEnrollment(
      AddEnrollment event, Emitter<EnrollmentState> emit) async {
    if (state.enrollmentStatus != EnrollmentStatus.adding && state.isValid) {
      emit(state.copyWith(enrollmentStatus: EnrollmentStatus.adding));
      final response = await comRepo.postData(
        data: {
          "student": state.studentId.value,
          "course": state.courseId.value
        },
        path: enrollmentPath,
      );
      if (!(response == null)) {
        //success
        emit(state.copyWith(enrollmentStatus: EnrollmentStatus.addingSuccess));
        add(GetStartEnrollment());
      } else {
        emit(state.copyWith(enrollmentStatus: EnrollmentStatus.addingFail));
      }
    }
  }

  FutureOr<void> _onChangeCourseId(
      ChangeCourseId event, Emitter<EnrollmentState> emit) {
    final courseId = FormInt.dirty(value: event.id);
    emit(state.copyWith(
        courseId: courseId,
        isValid: Formz.validate([
          courseId,
          state.studentId,
        ])));
  }

  FutureOr<void> _onChangeStudentId(
      ChangeStudentId event, Emitter<EnrollmentState> emit) {
    final studentId = FormInt.dirty(value: event.id);
    emit(state.copyWith(
        studentId: studentId,
        isValid: Formz.validate([
          state.courseId,
          studentId,
        ])));
  }

  FutureOr<void> _onSearchEnrollment(
      SearchEnrollment event, Emitter<EnrollmentState> emit) async {
    if (state.enrollmentStatus != EnrollmentStatus.searching) {
      //search
      final response =
          await comRepo.search(path: enrollmentPath, data: event.value);
      if (!(response == null)) {
        final studentResponse = EnrollmentListResponse.fromJson(response);
        //success
        emit(state.copyWith(
          enrollmentStatus: EnrollmentStatus.searchingSuccess,
          hasMore: studentResponse.next == null ? false : true,
          next: studentResponse.next,
          enrollments: studentResponse.results,
        ));
      } else {
        //fail
        emit(state.copyWith(
          enrollmentStatus: EnrollmentStatus.searchingFail,
          error: "search discount error!",
        ));
      }
    }
  }
}
