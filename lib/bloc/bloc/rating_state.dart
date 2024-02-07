part of 'rating_bloc.dart';

enum RatingStatus {
  adding,
  deleting,
  updating,
  searching,
  addingSuccess,
  updatingSuccess,
  deletingSuccess,
  searchingSuccess,
  updatingFail,
  deletingFail,
  addingFail,
  searchingFail,
  initial,
  loading,
}

class RatingState extends Equatable {
  final Rating? selectedRating;

  //form-data
  final RatingStatus ratingStatus;
  final RequestStatus status;
  final FormzSubmissionStatus formStatus;
  final FormDoubleRequired rating;
  final FormInt courseId;
  final FormInt studentId;
  //
  final bool hasMore;
  final String? next;
  final List<Rating>? ratings;
  final String? error;
  final bool isValid;
  const RatingState({
    this.ratingStatus = RatingStatus.initial,
    this.ratings,
    this.hasMore = false,
    this.isValid = false,
    this.next,
    this.error,
    this.status = RequestStatus.initial,
    this.selectedRating,
    this.rating = const FormDoubleRequired.pure(),
    this.courseId = const FormInt.pure(),
    this.studentId = const FormInt.pure(),
    this.formStatus = FormzSubmissionStatus.initial,
  });

  @override
  List<Object?> get props => [
        ratingStatus,
        ratings,
        hasMore,
        isValid,
        next,
        error,
        status,
        selectedRating,
        rating,
        courseId,
        studentId,
        formStatus,
      ];

  RatingState copyWith({
    bool clearSelectedRating = false,
    Rating? selectedRating,
    RatingStatus? ratingStatus,
    RequestStatus? status,
    FormzSubmissionStatus? formStatus,
    FormDoubleRequired? rating,
    FormInt? courseId,
    FormInt? studentId,
    bool? hasMore,
    String? next,
    List<Rating>? ratings,
    String? error,
    bool? isValid,
  }) {
    return RatingState(
      selectedRating:
          clearSelectedRating ? null : selectedRating ?? this.selectedRating,
      ratingStatus: ratingStatus ?? this.ratingStatus,
      status: status ?? this.status,
      formStatus: formStatus ?? this.formStatus,
      rating: rating ?? this.rating,
      courseId: courseId ?? this.courseId,
      studentId: studentId ?? this.studentId,
      hasMore: hasMore ?? this.hasMore,
      next: next ?? this.next,
      ratings: ratings ?? this.ratings,
      error: error ?? this.error,
      isValid: isValid ?? this.isValid,
    );
  }
}
