part of 'student_bloc.dart';

enum StudentStatus {
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

class StudentState extends Equatable {
  final Student? selectedStudent;

  //form-data
  final StudentStatus studentStatus;
  final RequestStatus status;
  final FormzSubmissionStatus formStatus;
  final FormImage formAvatar;
  final FormStringRequired formUserName;
  final FormStringRequired formEmail;
  final FormStringRequired formPassword;
  final FormStringRequired formFirstName;
  final FormStringRequired formLastName;
  //
  final bool hasMore;
  final String? next;
  final List<Student>? students;
  final String? error;
  final bool isValid;
  const StudentState({
    this.studentStatus = StudentStatus.initial,
    this.students,
    this.hasMore = false,
    this.isValid = false,
    this.next,
    this.error,
    this.status = RequestStatus.initial,
    this.selectedStudent,
    this.formStatus = FormzSubmissionStatus.initial,
    this.formAvatar = const FormImage.pure(),
    this.formEmail = const FormStringRequired.pure(),
    this.formFirstName = const FormStringRequired.pure(),
    this.formLastName = const FormStringRequired.pure(),
    this.formPassword = const FormStringRequired.pure(),
    this.formUserName = const FormStringRequired.pure(),
  });

  @override
  List<Object?> get props => [
        studentStatus,
        students,
        hasMore,
        isValid,
        next,
        error,
        status,
        selectedStudent,
        formStatus,
        formAvatar,
        formUserName,
        formEmail,
        formPassword,
        formFirstName,
        formLastName,
      ];

  StudentState copyWith({
    bool clearSelectedStudent = false,
    Student? selectedStudent,
    StudentStatus? studentStatus,
    RequestStatus? status,
    FormzSubmissionStatus? formStatus,
    FormImage? formAvatar,
    FormStringRequired? formUserName,
    FormStringRequired? formEmail,
    FormStringRequired? formPassword,
    FormStringRequired? formFirstName,
    FormStringRequired? formLastName,
    bool? hasMore,
    String? next,
    List<Student>? students,
    String? error,
    bool? isValid,
  }) {
    return StudentState(
      selectedStudent:
          clearSelectedStudent ? null : selectedStudent ?? this.selectedStudent,
      studentStatus: studentStatus ?? this.studentStatus,
      status: status ?? this.status,
      formStatus: formStatus ?? this.formStatus,
      formAvatar: formAvatar ?? this.formAvatar,
      formEmail: formEmail ?? this.formEmail,
      formFirstName: formFirstName ?? this.formFirstName,
      formLastName: formLastName ?? this.formLastName,
      formPassword: formPassword ?? this.formPassword,
      formUserName: formUserName ?? this.formUserName,
      hasMore: hasMore ?? this.hasMore,
      next: next ?? this.next,
      students: students ?? this.students,
      error: error ?? this.error,
      isValid: isValid ?? this.isValid,
    );
  }
}
