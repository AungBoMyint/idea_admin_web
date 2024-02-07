part of 'course_bloc.dart';

class CourseEvent {}

class ChangeSelectedSection extends CourseEvent {
  final Section? section;
  ChangeSelectedSection({required this.section});
}

class UpdateCourseEvent extends CourseEvent {}

class ChangeSelectedLesson extends CourseEvent {
  final SubSection? lesson;
  ChangeSelectedLesson({required this.lesson});
}

class ChangeSelectedCourse extends CourseEvent {
  final Course? course;
  ChangeSelectedCourse({required this.course});
}

class SearchCourse extends CourseEvent {
  final String value;
  SearchCourse({required this.value});
}

class UpdateSection extends CourseEvent {}

class UpdateLesson extends CourseEvent {}

class ChangeSectionAdd extends CourseEvent {}

class ChangeLessonAdd extends CourseEvent {}

class GetStartCourseEvent extends CourseEvent {}

class GetMoreCourseEvent extends CourseEvent {}

class AddCourseEvent extends CourseEvent {}

class DeleteCourseEvent extends CourseEvent {
  final int id;
  DeleteCourseEvent({required this.id});
}

class ChangeImageEvent extends CourseEvent {
  final List<int> image;
  ChangeImageEvent({required this.image});
}

class ChangeVideoEvent extends CourseEvent {
  final Map<String, dynamic> data;
  ChangeVideoEvent({required this.data});
}

class ChangeTitleEvent extends CourseEvent {
  final String value;
  ChangeTitleEvent({required this.value});
}

class ChangeDescriptionEvent extends CourseEvent {
  final String value;
  ChangeDescriptionEvent({required this.value});
}

class ChangePriceEvent extends CourseEvent {
  final int value;
  ChangePriceEvent({required this.value});
}

class ChangeFeatureEvent extends CourseEvent {
  final bool value;
  ChangeFeatureEvent({required this.value});
}

class ChangeCategoryEvent extends CourseEvent {
  final int value;
  ChangeCategoryEvent({required this.value});
}

class PostSectionEvent extends CourseEvent {}

class PostLessonEvent extends CourseEvent {}

class ChangeSectionTitleEvent extends CourseEvent {
  final String value;
  ChangeSectionTitleEvent({required this.value});
}

class DeleteSectionEvent extends CourseEvent {
  final int id;
  DeleteSectionEvent({required this.id});
}

class DeleteLessonEvent extends CourseEvent {
  final int id;
  DeleteLessonEvent({required this.id});
}

class ChangeLessonTitleEvent extends CourseEvent {
  final String value;
  ChangeLessonTitleEvent({required this.value});
}

class ChangeLessonVideoEvent extends CourseEvent {
  final Map<String, dynamic> value;
  ChangeLessonVideoEvent({required this.value});
}

class ChangeLessonFileEvent extends CourseEvent {
  final Map<String, dynamic> value;
  ChangeLessonFileEvent({required this.value});
}
