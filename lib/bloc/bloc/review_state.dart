part of 'review_bloc.dart';

enum ReviewStatus {
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

class ReviewState extends Equatable {
  final Review? selectedReview;

  //form-data
  final ReviewStatus reviewStatus;
  final RequestStatus status;
  final FormzSubmissionStatus formStatus;
  final FormStringRequired review;
  final FormInt courseId;
  final FormInt studentId;
  //
  final bool hasMore;
  final String? next;
  final List<Review>? reviews;
  final String? error;
  final bool isValid;
  const ReviewState({
    this.reviewStatus = ReviewStatus.initial,
    this.reviews,
    this.hasMore = false,
    this.isValid = false,
    this.next,
    this.error,
    this.status = RequestStatus.initial,
    this.selectedReview,
    this.review = const FormStringRequired.pure(),
    this.courseId = const FormInt.pure(),
    this.studentId = const FormInt.pure(),
    this.formStatus = FormzSubmissionStatus.initial,
  });

  @override
  List<Object?> get props => [
        reviewStatus,
        reviews,
        hasMore,
        isValid,
        next,
        error,
        status,
        selectedReview,
        review,
        courseId,
        studentId,
        formStatus,
      ];

  ReviewState copyWith({
    bool clearSelectedReview = false,
    Review? selectedReview,
    ReviewStatus? reviewStatus,
    RequestStatus? status,
    FormzSubmissionStatus? formStatus,
    FormStringRequired? review,
    FormInt? courseId,
    FormInt? studentId,
    bool? hasMore,
    String? next,
    List<Review>? reviews,
    String? error,
    bool? isValid,
  }) {
    return ReviewState(
      selectedReview:
          clearSelectedReview ? null : selectedReview ?? this.selectedReview,
      reviewStatus: reviewStatus ?? this.reviewStatus,
      status: status ?? this.status,
      formStatus: formStatus ?? this.formStatus,
      review: review ?? this.review,
      courseId: courseId ?? this.courseId,
      studentId: studentId ?? this.studentId,
      hasMore: hasMore ?? this.hasMore,
      next: next ?? this.next,
      reviews: reviews ?? this.reviews,
      error: error ?? this.error,
      isValid: isValid ?? this.isValid,
    );
  }
}
