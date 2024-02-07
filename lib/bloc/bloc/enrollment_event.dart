part of 'enrollment_bloc.dart';

class EnrollmentEvent {}

class SearchEnrollment extends EnrollmentEvent {
  final String value;
  SearchEnrollment({required this.value});
}

class GetStartEnrollment extends EnrollmentEvent {}

class GetMoreEnrollment extends EnrollmentEvent {}

class AddEnrollment extends EnrollmentEvent {}

class ChangeCourseId extends EnrollmentEvent {
  final int id;
  ChangeCourseId({required this.id});
}

class ChangeStudentId extends EnrollmentEvent {
  final int id;
  ChangeStudentId({required this.id});
}
