// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'slider_bloc.dart';

enum SliderStatus {
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
  loading,
  initial
}

class SliderState extends Equatable {
  final SliderStatus sliderStatus;
  final RequestStatus status;
  final FormzSubmissionStatus formStatus;
  final bool hasMore;
  final String? next;
  final List<Slider>? sliders;
  final String? error;
  final FormTitle formTitle;
  final FormImage formImage;
  final FormMessengerLink? formMessenger;
  final FormFacebookLink? formFacebook;
  final FormYoutubeLink? formYoutube;
  final FormCourseLink? formCourse;
  final bool isValid;
  final Slider? selectedSlider;
  const SliderState({
    this.formCourse,
    this.formFacebook,
    this.formMessenger,
    this.formYoutube,
    this.selectedSlider,
    this.isValid = false,
    this.formTitle = const FormTitle.pure(),
    this.formImage = const FormImage.pure(),
    this.formStatus = FormzSubmissionStatus.initial,
    this.sliderStatus = SliderStatus.initial,
    this.status = RequestStatus.initial,
    this.hasMore = false,
    this.next,
    this.sliders,
    this.error,
  });

  @override
  List<Object?> get props => [
        sliders,
        sliderStatus,
        status,
        hasMore,
        next,
        error,
        formImage,
        formTitle,
        formMessenger,
        formFacebook,
        formYoutube,
        formCourse,
        formStatus,
        isValid,
        selectedSlider,
      ];

  SliderState copyWith({
    SliderStatus? sliderStatus,
    RequestStatus? status,
    FormzSubmissionStatus? formStatus,
    bool? hasMore,
    String? next,
    List<Slider>? sliders,
    String? error,
    FormTitle? formTitle,
    FormImage? formImage,
    FormMessengerLink? formMessenger,
    FormFacebookLink? formFacebook,
    FormYoutubeLink? formYoutube,
    FormCourseLink? formCourse,
    bool? isValid,
    Slider? selectedSlider,
    bool clearSelectedSlider = false,
  }) {
    return SliderState(
      formCourse: formCourse ?? this.formCourse,
      formFacebook: formFacebook ?? this.formFacebook,
      formMessenger: formMessenger ?? this.formMessenger,
      formYoutube: formYoutube ?? this.formYoutube,
      selectedSlider:
          clearSelectedSlider ? null : selectedSlider ?? this.selectedSlider,
      isValid: isValid ?? this.isValid,
      sliderStatus: sliderStatus ?? this.sliderStatus,
      status: status ?? this.status,
      formStatus: formStatus ?? this.formStatus,
      hasMore: hasMore ?? this.hasMore,
      next: next ?? this.next,
      sliders: sliders ?? this.sliders,
      error: error ?? this.error,
      formTitle: formTitle ?? this.formTitle,
      formImage: formImage ?? this.formImage,
    );
  }
}
