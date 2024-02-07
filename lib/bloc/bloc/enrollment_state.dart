part of 'enrollment_bloc.dart';

enum EnrollmentStatus {
  adding,
  searching,
  addingSuccess,
  searchingSuccess,
  addingFail,
  searchingFail,
  initial,
  loading,
}

class EnrollmentState extends Equatable {
  //form-data
  final EnrollmentStatus enrollmentStatus;
  final RequestStatus status;
  final FormzSubmissionStatus formStatus;
  final FormInt courseId;
  final FormInt studentId;
  //
  final bool hasMore;
  final String? next;
  final List<Enrollment>? enrollments;
  final String? error;
  final bool isValid;
  const EnrollmentState({
    this.enrollmentStatus = EnrollmentStatus.initial,
    this.enrollments,
    this.hasMore = false,
    this.isValid = false,
    this.next,
    this.error,
    this.status = RequestStatus.initial,
    this.courseId = const FormInt.pure(),
    this.studentId = const FormInt.pure(),
    this.formStatus = FormzSubmissionStatus.initial,
  });

  @override
  List<Object?> get props => [
        enrollmentStatus,
        enrollments,
        hasMore,
        isValid,
        next,
        error,
        status,
        courseId,
        studentId,
        formStatus,
      ];

  EnrollmentState copyWith({
    bool clearSelectedEnrollment = false,
    Enrollment? selectedEnrollment,
    EnrollmentStatus? enrollmentStatus,
    RequestStatus? status,
    FormzSubmissionStatus? formStatus,
    FormInt? courseId,
    FormInt? studentId,
    bool? hasMore,
    String? next,
    List<Enrollment>? enrollments,
    String? error,
    bool? isValid,
  }) {
    return EnrollmentState(
      enrollmentStatus: enrollmentStatus ?? this.enrollmentStatus,
      status: status ?? this.status,
      formStatus: formStatus ?? this.formStatus,
      courseId: courseId ?? this.courseId,
      studentId: studentId ?? this.studentId,
      hasMore: hasMore ?? this.hasMore,
      next: next ?? this.next,
      enrollments: enrollments ?? this.enrollments,
      error: error ?? this.error,
      isValid: isValid ?? this.isValid,
    );
  }
}
