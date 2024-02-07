part of 'review_bloc.dart';

class ReviewEvent {}

class GetStartReview extends ReviewEvent {}

class GetMoreReview extends ReviewEvent {}

class SearchReview extends ReviewEvent {
  final String value;
  SearchReview({required this.value});
}

class AddReview extends ReviewEvent {}

class UpdateReview extends ReviewEvent {}

class DeleteReview extends ReviewEvent {
  final int id;
  DeleteReview({required this.id});
}

class ChangeSelectedReview extends ReviewEvent {
  final Review? review;
  ChangeSelectedReview({this.review});
}

class ChangeReview extends ReviewEvent {
  final String value;
  ChangeReview({required this.value});
}

class ChangeCourseId extends ReviewEvent {
  final int value;
  ChangeCourseId({required this.value});
}

class ChangeStudentId extends ReviewEvent {
  final int value;
  ChangeStudentId({required this.value});
}
