// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'course_bloc.dart';

enum CourseStatus {
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
  addingSection,
  addingSectionSuccess,
  addingSectionFail,
  updatingSection,
  updatingSectionSuccess,
  updatingSectionFail,
  deletingSection,
  deletingSectionSuccess,
  deletingSectionFail,

  addingLesson,
  addingLessonSuccess,
  addingLessonFail,
  updatingLesson,
  updatingLessonSuccess,
  updatingLessonFail,
  deletingLesson,
  deletingLessonSuccess,
  deletingLessonFail,
}

class CourseState extends Equatable {
  final Section? selectedSection;
  final SubSection? selectedLesson;
  final bool isSectionAdd;
  final bool isLessonAdd;
  //form-data
  final CourseStatus courseStatus;
  final RequestStatus status;
  final FormzSubmissionStatus formStatus;
  final FormStringRequired title;
  final FormStringRequired description;
  final FormInt price;
  final FormBool featured;
  final FormInt category;
  final FormImage image;
  final FormVideo video;
  //Section
  final FormStringRequired sectionTitle;
  //Lesson
  final FormStringRequired lessonTitle;
  final FormVideo lessonVideo;
  final FormVideo lessonFile;
  //
  final bool hasMore;
  final String? next;
  final List<Course>? courses;
  final String? error;
  final bool isValid;
  final Course? selectedCourse;
  final double uploadPercentage;
  final List<double> receivePercentage;
  const CourseState({
    this.selectedSection,
    this.selectedLesson,
    this.uploadPercentage = 0,
    this.receivePercentage = const [0, 0, 0],
    this.isLessonAdd = false,
    this.isSectionAdd = false,
    this.courseStatus = CourseStatus.initial,
    this.courses,
    this.description = const FormStringRequired.pure(),
    this.error,
    this.featured = const FormBool.pure(),
    this.category = const FormInt.pure(),
    this.image = const FormImage.pure(),
    this.price = const FormInt.pure(),
    this.formStatus = FormzSubmissionStatus.initial,
    this.video = const FormVideo.pure(),
    this.sectionTitle = const FormStringRequired.pure(),
    this.lessonTitle = const FormStringRequired.pure(),
    this.lessonVideo = const FormVideo.pure(),
    this.lessonFile = const FormVideo.pure(),
    this.hasMore = false,
    this.isValid = false,
    this.next,
    this.selectedCourse,
    this.status = RequestStatus.initial,
    this.title = const FormStringRequired.pure(),
  });

  @override
  List<Object?> get props => [
        selectedSection,
        selectedLesson,
        isLessonAdd,
        isSectionAdd,
        courseStatus,
        courses,
        description,
        error,
        featured,
        price,
        image,
        category,
        formStatus,
        video,
        hasMore,
        isValid,
        next,
        selectedCourse,
        status,
        title,
        uploadPercentage,
        receivePercentage,
        sectionTitle,
        lessonTitle,
        lessonVideo,
        lessonFile,
      ];

  CourseState copyWith({
    Section? selectedSection,
    SubSection? selectedLesson,
    bool? isSectionAdd,
    bool? isLessonAdd,
    CourseStatus? courseStatus,
    RequestStatus? status,
    FormzSubmissionStatus? formStatus,
    FormStringRequired? title,
    FormStringRequired? description,
    FormInt? price,
    FormBool? featured,
    FormInt? category,
    FormImage? image,
    FormVideo? video,
    FormStringRequired? sectionTitle,
    //Lesson
    FormStringRequired? lessonTitle,
    FormVideo? lessonVideo,
    FormVideo? lessonFile,
    bool? hasMore,
    String? next,
    List<Course>? courses,
    String? error,
    bool? isValid,
    Course? selectedCourse,
    bool clearSelectedCourse = false,
    bool clearSelectedSection = false,
    bool clearSelectedLesson = false,
    double? uploadPercentage,
    List<double>? receivePercentage,
  }) {
    return CourseState(
      sectionTitle: sectionTitle ?? this.sectionTitle,
      //Lesson
      lessonTitle: lessonTitle ?? this.lessonTitle,
      lessonVideo: lessonVideo ?? this.lessonVideo,
      lessonFile: lessonFile ?? this.lessonFile,
      uploadPercentage: uploadPercentage ?? this.uploadPercentage,
      receivePercentage: receivePercentage ?? this.receivePercentage,
      selectedSection:
          clearSelectedSection ? null : selectedSection ?? this.selectedSection,
      isSectionAdd: isSectionAdd ?? this.isSectionAdd,
      isLessonAdd: isLessonAdd ?? this.isLessonAdd,
      courseStatus: courseStatus ?? this.courseStatus,
      status: status ?? this.status,
      formStatus: formStatus ?? this.formStatus,
      title: title ?? this.title,
      description: description ?? this.description,
      price: price ?? this.price,
      featured: featured ?? this.featured,
      category: category ?? this.category,
      image: image ?? this.image,
      video: video ?? this.video,
      hasMore: hasMore ?? this.hasMore,
      next: next ?? this.next,
      courses: courses ?? this.courses,
      error: error ?? this.error,
      isValid: isValid ?? this.isValid,
      selectedLesson:
          clearSelectedLesson ? null : selectedLesson ?? this.selectedLesson,
      selectedCourse:
          clearSelectedCourse ? null : selectedCourse ?? this.selectedCourse,
    );
  }
}
