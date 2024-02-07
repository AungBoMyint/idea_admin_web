import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mmlearning_admin/api_path.dart';
import 'package:mmlearning_admin/core/data/common_repository.dart';
import 'package:mmlearning_admin/form/form_double_required.dart';
import 'package:mmlearning_admin/form/form_int.dart';
import 'package:mmlearning_admin/form/form_string_required.dart';
import 'package:mmlearning_admin/model/rating_list_response.dart';

import '../../enum_class.dart';
import '../../model/rating.dart';

part 'rating_event.dart';
part 'rating_state.dart';

class RatingBloc extends Bloc<RatingEvent, RatingState> {
  CommonRepositoryApi comRepo;
  RatingBloc(this.comRepo) : super(RatingState()) {
    on<GetStartRating>(_onGetStartRating);
    on<GetMoreRating>(_onGetMoreRating);
    on<AddRating>(_onAddRating);
    on<ChangeSelectedRating>(_onChangeSelectedRating);
    on<UpdateRating>(_onUpdateRating);
    on<DeleteRating>(_onDeleteRating);
    on<ChangeRating>(_onChangeRating);
    on<ChangeCourseId>(_onChangeCourseId);
    on<ChangeStudentId>(_onChangeStudentId);
    on<SearchRating>(_onSearchRating);
  }

  FutureOr<void> _onChangeRating(
      ChangeRating event, Emitter<RatingState> emit) {
    final rating = FormDoubleRequired.dirty(value: event.value);
    emit(state.copyWith(
        rating: rating,
        isValid: Formz.validate([
          rating,
          state.courseId,
          state.studentId,
        ])));
  }

  FutureOr<void> _onChangeCourseId(
      ChangeCourseId event, Emitter<RatingState> emit) {
    final courseId = FormInt.dirty(value: event.id);
    emit(state.copyWith(
        courseId: courseId,
        isValid: Formz.validate([state.rating, courseId, state.studentId])));
  }

  FutureOr<void> _onChangeStudentId(
      ChangeStudentId event, Emitter<RatingState> emit) {
    final studentId = FormInt.dirty(value: event.id);
    emit(state.copyWith(
        studentId: studentId,
        isValid: Formz.validate([
          state.rating,
          state.courseId,
          studentId,
        ])));
  }

  FutureOr<void> _onGetStartRating(
      GetStartRating event, Emitter<RatingState> emit) async {
    emit(state.copyWith(status: RequestStatus.fetching));
    final response = await comRepo.getRating(ratingPath);
    if (response.error == null) {
      //success
      emit(state.copyWith(
        status: RequestStatus.success,
        hasMore: response.next == null ? false : true,
        next: response.next,
        ratings: response.results,
      ));
    } else {
      //fail
      emit(state.copyWith(
        status: RequestStatus.error,
        error: response.error?.detail,
      ));
    }
  }

  FutureOr<void> _onAddRating(
      AddRating event, Emitter<RatingState> emit) async {
    if (state.ratingStatus != RatingStatus.adding && state.isValid) {
      emit(state.copyWith(ratingStatus: RatingStatus.adding));
      final response = await comRepo.postData(
        data: {
          "rating": state.rating.value,
          "course": state.courseId.value,
          "student": state.studentId.value,
        },
        path: ratingPath,
      );
      if (!(response == null)) {
        //success
        emit(state.copyWith(ratingStatus: RatingStatus.addingSuccess));
        add(GetStartRating());
      } else {
        emit(state.copyWith(ratingStatus: RatingStatus.addingFail));
      }
    }
  }

  FutureOr<void> _onGetMoreRating(
      GetMoreRating event, Emitter<RatingState> emit) async {
    if (state.hasMore) {
      //if has more
      emit(state.copyWith(status: RequestStatus.morefetching));
      final response = await comRepo.getRating(state.next!);
      if (response.results?.isNotEmpty == true) {
        List<Rating> previousList = List.from(state.ratings!);
        previousList.addAll(response.results!);
        emit(state.copyWith(
          status: RequestStatus.success,
          ratings: previousList,
          hasMore: response.next == null ? false : true,
          next: response.next,
        ));
      }
    }
  }

  FutureOr<void> _onUpdateRating(
      UpdateRating event, Emitter<RatingState> emit) async {
    if (state.isValid && state.formStatus != FormzSubmissionStatus.inProgress) {
      //make uploading
      emit(state.copyWith(
          formStatus: FormzSubmissionStatus.inProgress,
          ratingStatus: RatingStatus.updating));
      var response = await comRepo.updateData(data: {
        "rating": state.rating.value,
        "course": state.courseId.value,
        "student": state.studentId.value,
      }, path: "$ratingPath${state.selectedRating!.id}/");

      if (response == null) {
        //fail
        emit(state.copyWith(
          formStatus: FormzSubmissionStatus.failure,
          ratingStatus: RatingStatus.updatingFail,
        ));
      } else {
        emit(state.copyWith(
          formStatus: FormzSubmissionStatus.success,
          ratingStatus: RatingStatus.updatingSuccess,
          clearSelectedRating: true,
          selectedRating: null,
          rating: const FormDoubleRequired.pure(),
          courseId: const FormInt.pure(),
          studentId: const FormInt.pure(),
        ));
        add(GetStartRating());
      }
    }
  }

  FutureOr<void> _onDeleteRating(
      DeleteRating event, Emitter<RatingState> emit) async {
    emit(state.copyWith(ratingStatus: RatingStatus.deleting));

    bool response = await comRepo.delete("$ratingPath${event.id}/");

    if (response) {
      //success
      emit(state.copyWith(
        ratingStatus: RatingStatus.deletingSuccess,
      ));
      List<Rating> ratings = List.from(state.ratings ?? []);
      ratings.removeWhere((element) => element.id == event.id);
      emit(state.copyWith(ratings: ratings));
    } else {
      emit(state.copyWith(
        ratingStatus: RatingStatus.deletingFail,
      ));
    }
  }

  FutureOr<void> _onChangeSelectedRating(
      ChangeSelectedRating event, Emitter<RatingState> emit) async {
    if (event.rating == null) {
      //need to clear
      emit(state.copyWith(
        clearSelectedRating: true,
        selectedRating: null,
        rating: const FormDoubleRequired.pure(),
        courseId: const FormInt.pure(),
        studentId: const FormInt.pure(),
      ));
    } else {
      emit(state.copyWith(ratingStatus: RatingStatus.loading));
      final response =
          await comRepo.get(path: "$ratingPath${event.rating!.id}/");
      final rating = Rating.fromJson(response as Map<String, dynamic>);
      emit(state.copyWith(
        ratingStatus: RatingStatus.initial,
        selectedRating: rating,
        rating: FormDoubleRequired.dirty(value: rating.rating),
        courseId: FormInt.dirty(value: rating.course),
        studentId: FormInt.dirty(value: rating.student),
      ));
    }
  }

  FutureOr<void> _onSearchRating(
      SearchRating event, Emitter<RatingState> emit) async {
    if (state.ratingStatus != RatingStatus.searching) {
      //search
      final response =
          await comRepo.search(path: ratingPath, data: event.value);
      if (!(response == null)) {
        final studentResponse = RatingListResponse.fromJson(response);
        //success
        emit(state.copyWith(
          ratingStatus: RatingStatus.searchingSuccess,
          hasMore: studentResponse.next == null ? false : true,
          next: studentResponse.next,
          ratings: studentResponse.results,
        ));
      } else {
        //fail
        emit(state.copyWith(
          ratingStatus: RatingStatus.searchingFail,
          error: "search discount error!",
        ));
      }
    }
  }
}
