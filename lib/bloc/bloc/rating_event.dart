part of 'rating_bloc.dart';

class RatingEvent {}

class GetStartRating extends RatingEvent {}

class GetMoreRating extends RatingEvent {}

class SearchRating extends RatingEvent {
  final String value;
  SearchRating({required this.value});
}

class ChangeSelectedRating extends RatingEvent {
  final Rating? rating;
  ChangeSelectedRating({this.rating});
}

class AddRating extends RatingEvent {}

class UpdateRating extends RatingEvent {}

class DeleteRating extends RatingEvent {
  final int id;
  DeleteRating({required this.id});
}

class ChangeRating extends RatingEvent {
  final double value;
  ChangeRating({required this.value});
}

class ChangeStudentId extends RatingEvent {
  final int id;
  ChangeStudentId({required this.id});
}

class ChangeCourseId extends RatingEvent {
  final int id;
  ChangeCourseId({required this.id});
}
