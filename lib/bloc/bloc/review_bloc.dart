import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mmlearning_admin/api_path.dart';
import 'package:mmlearning_admin/core/data/common_repository.dart';
import 'package:mmlearning_admin/form/form_string_required.dart';
import 'package:mmlearning_admin/model/review_list_response.dart';

import '../../enum_class.dart';
import '../../form/form_int.dart';
import '../../model/review.dart';
import '../../model/review.dart';

part 'review_event.dart';
part 'review_state.dart';

class ReviewBloc extends Bloc<ReviewEvent, ReviewState> {
  CommonRepositoryApi comRepo;
  ReviewBloc(this.comRepo) : super(const ReviewState()) {
    on<GetStartReview>(_onGetStartReview);
    on<GetMoreReview>(_onGetMoreReview);
    on<AddReview>(_onAddReview);
    on<UpdateReview>(_onUpdateReview);
    on<DeleteReview>(_onDeleteReview);
    on<ChangeSelectedReview>(_onChangeSelectedReview);
    on<ChangeReview>(_onChangeReview);
    on<ChangeCourseId>(_onChangeCourseId);
    on<ChangeStudentId>(_onChangeStudentId);
    on<SearchReview>(_onSearchReview);
  }

  FutureOr<void> _onGetStartReview(
      GetStartReview event, Emitter<ReviewState> emit) async {
    emit(state.copyWith(status: RequestStatus.fetching));
    final response = await comRepo.getReview(reviewPath);
    if (response.error == null) {
      //success
      emit(state.copyWith(
        status: RequestStatus.success,
        hasMore: response.next == null ? false : true,
        next: response.next,
        reviews: response.results,
      ));
    } else {
      //fail
      emit(state.copyWith(
        status: RequestStatus.error,
        error: response.error?.detail,
      ));
    }
  }

  FutureOr<void> _onGetMoreReview(
      GetMoreReview event, Emitter<ReviewState> emit) async {
    if (state.hasMore) {
      //if has more
      emit(state.copyWith(status: RequestStatus.morefetching));
      final response = await comRepo.getReview(state.next!);
      if (response.results?.isNotEmpty == true) {
        List<Review> previousList = List.from(state.reviews!);
        previousList.addAll(response.results!);
        emit(state.copyWith(
          status: RequestStatus.success,
          reviews: previousList,
          hasMore: response.next == null ? false : true,
          next: response.next,
        ));
      }
    }
  }

  FutureOr<void> _onAddReview(
      AddReview event, Emitter<ReviewState> emit) async {
    if (state.reviewStatus != ReviewStatus.adding && state.isValid) {
      emit(state.copyWith(reviewStatus: ReviewStatus.adding));
      final response = await comRepo.postData(
        data: {
          "review": state.review.value,
          "course": state.courseId.value,
          "student": state.studentId.value,
        },
        path: reviewPath,
      );
      if (!(response == null)) {
        //success
        emit(state.copyWith(reviewStatus: ReviewStatus.addingSuccess));
        add(GetStartReview());
      } else {
        emit(state.copyWith(reviewStatus: ReviewStatus.addingFail));
      }
    }
  }

  FutureOr<void> _onUpdateReview(
      UpdateReview event, Emitter<ReviewState> emit) async {
    if (state.isValid && state.formStatus != FormzSubmissionStatus.inProgress) {
      //make uploading
      emit(state.copyWith(
          formStatus: FormzSubmissionStatus.inProgress,
          reviewStatus: ReviewStatus.updating));
      var response = await comRepo.updateData(data: {
        "review": state.review.value,
        "course": state.courseId.value,
        "student": state.studentId.value,
      }, path: "$reviewPath${state.selectedReview!.id}/");

      if (response == null) {
        //fail
        emit(state.copyWith(
          formStatus: FormzSubmissionStatus.failure,
          reviewStatus: ReviewStatus.updatingFail,
        ));
      } else {
        emit(state.copyWith(
          formStatus: FormzSubmissionStatus.success,
          reviewStatus: ReviewStatus.updatingSuccess,
          clearSelectedReview: true,
          selectedReview: null,
          review: const FormStringRequired.pure(),
          courseId: const FormInt.pure(),
          studentId: const FormInt.pure(),
        ));
        add(GetStartReview());
      }
    }
  }

  FutureOr<void> _onDeleteReview(
      DeleteReview event, Emitter<ReviewState> emit) async {
    emit(state.copyWith(reviewStatus: ReviewStatus.deleting));

    bool response = await comRepo.delete("$reviewPath${event.id}/");

    if (response) {
      //success
      emit(state.copyWith(
        reviewStatus: ReviewStatus.deletingSuccess,
      ));
      List<Review> ratings = List.from(state.reviews ?? []);
      ratings.removeWhere((element) => element.id == event.id);
      emit(state.copyWith(reviews: ratings));
    } else {
      emit(state.copyWith(
        reviewStatus: ReviewStatus.deletingFail,
      ));
    }
  }

  FutureOr<void> _onChangeSelectedReview(
      ChangeSelectedReview event, Emitter<ReviewState> emit) async {
    if (event.review == null) {
      //need to clear
      emit(state.copyWith(
        clearSelectedReview: true,
        selectedReview: null,
        review: const FormStringRequired.pure(),
        courseId: const FormInt.pure(),
        studentId: const FormInt.pure(),
      ));
    } else {
      emit(state.copyWith(reviewStatus: ReviewStatus.loading));
      final response =
          await comRepo.get(path: "$reviewPath${event.review!.id}/");
      final rating = Review.fromJson(response as Map<String, dynamic>);
      emit(state.copyWith(
        reviewStatus: ReviewStatus.initial,
        selectedReview: rating,
        review: FormStringRequired.dirty(value: rating.review),
        courseId: FormInt.dirty(value: rating.course),
        studentId: FormInt.dirty(value: rating.student),
      ));
    }
  }

  FutureOr<void> _onChangeReview(
      ChangeReview event, Emitter<ReviewState> emit) {
    final review = FormStringRequired.dirty(value: event.value);
    emit(state.copyWith(
        review: review,
        isValid: Formz.validate([
          review,
          state.courseId,
          state.studentId,
        ])));
  }

  FutureOr<void> _onChangeCourseId(
      ChangeCourseId event, Emitter<ReviewState> emit) {
    final courseId = FormInt.dirty(value: event.value);
    emit(state.copyWith(
        courseId: courseId,
        isValid: Formz.validate([
          state.review,
          courseId,
          state.studentId,
        ])));
  }

  FutureOr<void> _onChangeStudentId(
      ChangeStudentId event, Emitter<ReviewState> emit) {
    final studentId = FormInt.dirty(value: event.value);
    emit(state.copyWith(
        studentId: studentId,
        isValid: Formz.validate([
          state.review,
          state.courseId,
          studentId,
        ])));
  }

  FutureOr<void> _onSearchReview(
      SearchReview event, Emitter<ReviewState> emit) async {
    if (state.reviewStatus != ReviewStatus.searching) {
      //search
      final response =
          await comRepo.search(path: reviewPath, data: event.value);
      if (!(response == null)) {
        final studentResponse = ReviewListResponse.fromJson(response);
        //success
        emit(state.copyWith(
          reviewStatus: ReviewStatus.searchingSuccess,
          hasMore: studentResponse.next == null ? false : true,
          next: studentResponse.next,
          reviews: studentResponse.results,
        ));
      } else {
        //fail
        emit(state.copyWith(
          reviewStatus: ReviewStatus.searchingFail,
          error: "search discount error!",
        ));
      }
    }
  }
}
