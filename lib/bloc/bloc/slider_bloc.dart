import 'dart:async';
import 'dart:typed_data';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:mmlearning_admin/core/data/common_repository.dart';
import 'package:mmlearning_admin/form/form_facebook_link.dart';
import 'package:mmlearning_admin/form/form_messenger_link.dart';
import 'package:mmlearning_admin/form/form_youtube_link.dart';
import 'package:mmlearning_admin/function.dart';
import 'package:mmlearning_admin/main.dart';
import 'package:mmlearning_admin/model/form_image.dart';
import 'package:mmlearning_admin/model/title.dart';
import 'package:mmlearning_admin/slider/model/course_link.dart';
import 'package:mmlearning_admin/slider/model/facebook_link.dart';
import 'package:mmlearning_admin/slider/model/messenger_link.dart';
import 'package:mmlearning_admin/slider/model/youtube_link.dart';

import '../../api_path.dart';
import '../../enum_class.dart';
import '../../form/form_course_link.dart';
import '../../home/presentation/slider/slider_repository.dart';
import '../../slider/model/slider.dart';

part 'slider_event.dart';
part 'slider_state.dart';

class SliderBloc extends Bloc<SliderEvent, SliderState> {
  final SliderRepositoryApi sliderRepo;
  /*  final CommonRepositoryApi commonRepo; */
  SliderBloc(this.sliderRepo /* , this.commonRepo */)
      : super(const SliderState()) {
    on<AddSliderEvent>(_onAddSlider);
    on<UpdateSliderEvent>(_onUpdateSlider);
    on<SliderStartGetEvent>(_onStartGet);
    on<SliderGetMoreEvent>(_onGetMore);
    on<TitleChangeEvent>(_onTitleChange);
    on<ImageChangeEvent>(_onImageChange);
    on<MessengerChangeEvent>(_onMessengerChange);
    on<FacebookChangeEvent>(_onFacebookChange);
    on<YoutubeChangeEvent>(_onYoutubeChange);
    on<CourseLinkChangeEvent>(_onCourseLinkChange);
    on<SetSelectedSlider>(_onSetSelectedSlider);
    on<DeleteSlider>(_onDeleteSlider);
    on<SearchSliderEvent>(_onSearchSlider);
  }

  FutureOr<void> _onStartGet(
      SliderStartGetEvent event, Emitter<SliderState> emit) async {
    emit(state.copyWith(status: RequestStatus.fetching));
    final response = await sliderRepo.getSlider(sliderPath);
    if (response.error == null) {
      //success
      emit(state.copyWith(
        status: RequestStatus.success,
        hasMore: response.next == null ? false : true,
        next: response.next,
        sliders: response.results,
      ));
    } else {
      //fail
      emit(state.copyWith(
        status: RequestStatus.error,
        error: response.error?.detail,
      ));
    }
  }

  FutureOr<void> _onGetMore(
      SliderGetMoreEvent event, Emitter<SliderState> emit) async {
    if (state.hasMore) {
      //if has more
      emit(state.copyWith(status: RequestStatus.morefetching));
      final response = await sliderRepo.getSlider(state.next!);
      if (response.results?.isNotEmpty == true) {
        List<Slider> previousList = List.from(state.sliders!);
        previousList.addAll(response.results!);
        emit(state.copyWith(
          status: RequestStatus.success,
          sliders: previousList,
          hasMore: response.next == null ? false : true,
          next: response.next,
        ));
      }
    }
  }

  FutureOr<void> _onAddSlider(
      AddSliderEvent event, Emitter<SliderState> emit) async {
    if (state.isValid && state.formStatus != FormzSubmissionStatus.inProgress) {
      //make uploading
      emit(state.copyWith(
          formStatus: FormzSubmissionStatus.inProgress,
          sliderStatus: SliderStatus.adding));
      bool response = await sliderRepo.postSlider(
        data: {
          "title": state.formTitle.value,
          "image": MultipartFile.fromBytes(
              Uint8List.fromList(state.formImage.value),
              filename: "${DateTime.now().toIso8601String()}.png"),
        },
        messengerLink: (state.formMessenger == null) ||
                (state.formMessenger?.value.isEmpty == true)
            ? null
            : MessengerLink(link: state.formMessenger!.value),
        facebookLink: (state.formFacebook == null) ||
                (state.formFacebook?.value.isEmpty == true)
            ? null
            : FacebookLink(link: state.formFacebook!.value),
        youtubeLink: (state.formYoutube == null) ||
                (state.formYoutube?.value.isEmpty == true)
            ? null
            : YoutubeLink(link: state.formYoutube!.value),
        courseLink: (state.formCourse == null) ||
                (state.formCourse?.value.isEmpty == true)
            ? null
            : state.formCourse!.value,
      );

      if (!response) {
        //fail
        emit(state.copyWith(
            formStatus: FormzSubmissionStatus.failure,
            sliderStatus: SliderStatus.addingFail));
      } else {
        emit(state.copyWith(
          formStatus: FormzSubmissionStatus.success,
          sliderStatus: SliderStatus.addingSuccess,
          //clear form
          formTitle: FormTitle.pure(),
          formCourse: FormCourseLink.pure(),
          formFacebook: FormFacebookLink.pure(),
          formImage: FormImage.pure(),
          formMessenger: FormMessengerLink.pure(),
          formYoutube: FormYoutubeLink.pure(),
        ));
        add(SliderStartGetEvent());
      }
    }
  }

  FutureOr<void> _onTitleChange(
      TitleChangeEvent event, Emitter<SliderState> emit) {
    final title = FormTitle.dirty(value: event.title);
    emit(state.copyWith(
        formTitle: title, isValid: Formz.validate([title, state.formImage])));
  }

  FutureOr<void> _onImageChange(
      ImageChangeEvent event, Emitter<SliderState> emit) {
    final image = FormImage.dirty(value: event.image);
    emit(state.copyWith(
        formImage: image, isValid: Formz.validate([image, state.formTitle])));
  }

  FutureOr<void> _onSetSelectedSlider(
      SetSelectedSlider event, Emitter<SliderState> emit) async {
    if (event.slider == null) {
      emit(
        state.copyWith(
          selectedSlider: null,
          clearSelectedSlider: true,
          formImage: const FormImage.pure(),
          formTitle: const FormTitle.pure(),
          isValid: false,
        ),
      );
    } else {
      emit(state.copyWith(sliderStatus: SliderStatus.loading));
      final response = await http.get(Uri.parse(event.slider!.image));
      final formImage = FormImage.dirty(value: response.bodyBytes);
      final formTitle = FormTitle.dirty(value: event.slider!.title);
      final messengerLink = FormMessengerLink.dirty(
          value: event.slider?.messengerlink?.link ?? "");
      final facebookLink =
          FormFacebookLink.dirty(value: event.slider?.facebooklink?.link ?? "");
      final youtubeLink =
          FormYoutubeLink.dirty(value: event.slider?.youtube?.link ?? "");
      final coursesLink = FormCourseLink.dirty(
          value: event.slider?.courselink?.course?.map((e) => e.id).toList() ??
              []);
      emit(
        state.copyWith(
            sliderStatus: SliderStatus.initial,
            selectedSlider: event.slider,
            clearSelectedSlider: false,
            formImage: formImage,
            formTitle: formTitle,
            formMessenger: messengerLink,
            formFacebook: facebookLink,
            formYoutube: youtubeLink,
            formCourse: coursesLink,
            isValid: Formz.validate([formImage, formTitle])),
      );
    }
  }

  FutureOr<void> _onDeleteSlider(
      DeleteSlider event, Emitter<SliderState> emit) async {
    emit(state.copyWith(sliderStatus: SliderStatus.deleting));

    bool response = await sliderRepo.deleteSlider(
      event.sliderID,
    );

    if (response) {
      //success
      emit(state.copyWith(
        sliderStatus: SliderStatus.deletingSuccess,
      ));
      add(SliderStartGetEvent());
    } else {
      emit(state.copyWith(
        sliderStatus: SliderStatus.deletingFail,
      ));
    }
  }

  FutureOr<void> _onUpdateSlider(
      UpdateSliderEvent event, Emitter<SliderState> emit) async {
    if (state.isValid && state.formStatus != FormzSubmissionStatus.inProgress) {
      //make uploading
      emit(state.copyWith(
          formStatus: FormzSubmissionStatus.inProgress,
          sliderStatus: SliderStatus.updating));
      bool response = await sliderRepo.updateSlider(
        data: {
          "title": state.formTitle.value,
          "image": MultipartFile.fromBytes(state.formImage.value,
              filename: "${DateTime.now().toIso8601String()}.png")
        },
        messengerLink: (state.formMessenger == null) ||
                (state.formMessenger?.value.isEmpty == true)
            ? null
            : MessengerLink(link: state.formMessenger!.value),
        facebookLink: (state.formFacebook == null) ||
                (state.formFacebook?.value.isEmpty == true)
            ? null
            : FacebookLink(link: state.formFacebook!.value),
        youtubeLink: (state.formYoutube == null) ||
                (state.formYoutube?.value.isEmpty == true)
            ? null
            : YoutubeLink(link: state.formYoutube!.value),
        courseLink: (state.formCourse == null) ||
                (state.formCourse?.value.isEmpty == true)
            ? null
            : state.formCourse!.value,
        sliderID: state.selectedSlider!.id,
      );

      if (!response) {
        //fail
        emit(state.copyWith(
          formStatus: FormzSubmissionStatus.failure,
          sliderStatus: SliderStatus.updatingFail,
        ));
      } else {
        emit(state.copyWith(
          formStatus: FormzSubmissionStatus.success,
          sliderStatus: SliderStatus.updatingSuccess,
        ));
        add(SliderStartGetEvent());
      }
    }
  }

  FutureOr<void> _onSearchSlider(
      SearchSliderEvent event, Emitter<SliderState> emit) async {
    /*  if (state.sliderStatus != SliderStatus.searching) {
      //search
      final response =
          await sliderRepo.searchSlider(path: SliderPath, data: event.data);
      if (response.error == null) {
        //success
        emit(state.copyWith(
         sliderStatus: SliderStatus.searchingSuccess,
          hasMore: response.next == null ? false : true,
          next: response.next,
          sliders: response.results,
        ));
      } else {
        //fail
        emit(state.copyWith(
          sliderStatus: SliderStatus.searchingFail,
          error: response.error?.detail,
        ));
      }
    } */
  }

  FutureOr<void> _onMessengerChange(
      MessengerChangeEvent event, Emitter<SliderState> emit) {
    final messenger = FormMessengerLink.dirty(value: event.value);
    emit(state.copyWith(formMessenger: messenger));
  }

  FutureOr<void> _onFacebookChange(
      FacebookChangeEvent event, Emitter<SliderState> emit) {
    final facebook = FormFacebookLink.dirty(value: event.value);
    emit(state.copyWith(formFacebook: facebook));
  }

  FutureOr<void> _onYoutubeChange(
      YoutubeChangeEvent event, Emitter<SliderState> emit) {
    final youtube = FormYoutubeLink.dirty(value: event.value);
    emit(state.copyWith(formYoutube: youtube));
  }

  FutureOr<void> _onCourseLinkChange(
      CourseLinkChangeEvent event, Emitter<SliderState> emit) {
    List<int> preList = List.from(state.formCourse?.value ?? []);
    if (preList.contains(event.id)) {
      preList.remove(event.id);
    } else {
      preList.add(event.id);
    }
    final courseLink = FormCourseLink.dirty(value: preList);
    emit(state.copyWith(formCourse: courseLink));
  }
}
