import 'dart:async';
import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:formz/formz.dart';
import 'package:mmlearning_admin/api_path.dart';
import 'package:mmlearning_admin/form/form_bool.dart';
import 'package:mmlearning_admin/form/form_id_list.dart';
import 'package:mmlearning_admin/form/form_int.dart';
import 'package:mmlearning_admin/form/form_string_required.dart';
import 'package:mmlearning_admin/form/form_video.dart';
import 'package:mmlearning_admin/function.dart';
import 'package:mmlearning_admin/home/presentation/course/course_repository.dart';
import 'package:mmlearning_admin/main.dart';
import 'package:mmlearning_admin/model/course.dart';
import 'package:mmlearning_admin/model/form_image.dart';
import 'package:mmlearning_admin/model/section.dart';

import '../../enum_class.dart';
import '../../model/pdf.dart';
import '../../model/subsection.dart';
import '../../model/video.dart';

part 'course_event.dart';
part 'course_state.dart';

class CourseBloc extends Bloc<CourseEvent, CourseState> {
  final CourseRepositoryApi courseRepo;
  CourseBloc(this.courseRepo) : super(const CourseState()) {
    on<SearchCourse>(_onSearchCourse);
    on<ChangeSelectedSection>(_onChangeSelectedSection);
    on<ChangeSectionAdd>(_onChangeSectionAdd);
    on<ChangeLessonAdd>(_onChangeLessonAdd);
    on<GetStartCourseEvent>(_onGetStartCourse);
    on<GetMoreCourseEvent>(_onGetMoreCourse);
    on<ChangeTitleEvent>(_onChangeTitle);
    on<ChangeDescriptionEvent>(_onChangeDescription);
    on<ChangeImageEvent>(_onChangeImage);
    on<ChangeVideoEvent>(_onChangeVideo);
    on<ChangePriceEvent>(_onChangePrice);
    on<ChangeFeatureEvent>(_onChangeFeature);
    on<ChangeCategoryEvent>(_onChangeCategory);
    on<AddCourseEvent>(_onAddCourse);
    on<UpdateCourseEvent>(_onUpdateCourse);
    on<DeleteCourseEvent>(_onDeleteCourse);
    on<ChangeSelectedCourse>(_onChangeSelectedCourse);
    on<ChangeSelectedLesson>(_onChangeSelectedLesson);
    on<UpdateSection>(_onUpdateSection);
    on<UpdateLesson>(_onUpdateLesson);
    //SectionForm
    on<PostSectionEvent>(_onPostSection);
    on<ChangeSectionTitleEvent>(_onChangeSectionTitle);
    on<DeleteSectionEvent>(_onDeleteSection);
    //LessonForm
    on<ChangeLessonTitleEvent>(_onChangeLessonTitle);
    on<ChangeLessonVideoEvent>(_onChangeLessonVideo);
    on<ChangeLessonFileEvent>(_onChangeLessonFile);
    on<PostLessonEvent>(_onPostLesson);
    on<DeleteLessonEvent>(_onDeleteLesson);
  }

  FutureOr<void> _onChangeSelectedSection(
      ChangeSelectedSection event, Emitter<CourseState> emit) async {
    if (event.section?.id == state.selectedSection?.id) {
      emit(state.copyWith(clearSelectedSection: true, selectedSection: null));
      return;
    }

    if (event.section == null) {
      //mean clear section
      emit(state.copyWith(
        clearSelectedSection: true,
        selectedSection: null,
        sectionTitle: const FormStringRequired.pure(),
      ));
    } else {
      emit(state.copyWith(
        selectedSection: event.section,
        sectionTitle: FormStringRequired.dirty(
          value: event.section!.title,
        ),
        isSectionAdd: true,
      ));
    }
  }

  FutureOr<void> _onChangeSectionAdd(
      ChangeSectionAdd event, Emitter<CourseState> emit) {
    emit(state.copyWith(
      isSectionAdd: !state.isSectionAdd,
    ));
  }

  FutureOr<void> _onChangeLessonAdd(
      ChangeLessonAdd event, Emitter<CourseState> emit) {
    emit(state.copyWith(isLessonAdd: !state.isLessonAdd));
  }

  FutureOr<void> _onGetStartCourse(
      GetStartCourseEvent event, Emitter<CourseState> emit) async {
    emit(state.copyWith(status: RequestStatus.fetching));
    final response = await courseRepo.getCourse(coursePath);
    if (response.error == null) {
      //success
      emit(state.copyWith(
        status: RequestStatus.success,
        hasMore: response.next == null ? false : true,
        next: response.next,
        courses: response.results,
      ));
    } else {
      //fail
      emit(state.copyWith(
        status: RequestStatus.error,
        error: response.error?.detail,
      ));
    }
  }

  FutureOr<void> _onGetMoreCourse(
      GetMoreCourseEvent event, Emitter<CourseState> emit) async {
    if (state.hasMore) {
      //if has more
      emit(state.copyWith(status: RequestStatus.morefetching));
      final response = await courseRepo.getCourse(state.next!);
      if (response.results?.isNotEmpty == true) {
        List<Course> previousList = List.from(state.courses!);
        previousList.addAll(response.results!);
        emit(state.copyWith(
          status: RequestStatus.success,
          courses: previousList,
          hasMore: response.next == null ? false : true,
          next: response.next,
        ));
      }
    }
  }

  FutureOr<void> _onChangeTitle(
      ChangeTitleEvent event, Emitter<CourseState> emit) {
    final title = FormStringRequired.dirty(value: event.value);
    emit(state.copyWith(
      title: title,
      isValid: Formz.validate([
        title,
        state.description,
        state.image,
        state.video,
        state.price,
        state.featured,
        state.category,
      ]),
    ));
  }

  FutureOr<void> _onChangeDescription(
      ChangeDescriptionEvent event, Emitter<CourseState> emit) {
    final desc = FormStringRequired.dirty(value: event.value);
    emit(state.copyWith(
      description: desc,
      isValid: Formz.validate([
        state.title,
        desc,
        state.image,
        state.video,
        state.price,
        state.featured,
        state.category,
      ]),
    ));
  }

  FutureOr<void> _onChangeImage(
      ChangeImageEvent event, Emitter<CourseState> emit) {
    final image = FormImage.dirty(value: event.image);
    emit(state.copyWith(
      image: image,
      isValid: Formz.validate([
        state.title,
        state.description,
        image,
        state.video,
        state.price,
        state.featured,
        state.category,
      ]),
    ));
  }

  FutureOr<void> _onChangeVideo(
      ChangeVideoEvent event, Emitter<CourseState> emit) {
    final video = FormVideo.dirty(value: event.data);
    emit(state.copyWith(
      video: video,
      isValid: Formz.validate([
        state.title,
        state.description,
        state.image,
        video,
        state.price,
        state.featured,
        state.category,
      ]),
    ));
  }

  FutureOr<void> _onChangePrice(
      ChangePriceEvent event, Emitter<CourseState> emit) {
    final price = FormInt.dirty(value: event.value);
    emit(state.copyWith(
      price: price,
      isValid: Formz.validate([
        state.title,
        state.description,
        state.image,
        state.video,
        price,
        state.featured,
        state.category,
      ]),
    ));
  }

  FutureOr<void> _onChangeFeature(
      ChangeFeatureEvent event, Emitter<CourseState> emit) {
    final featured = FormBool.dirty(value: event.value);
    emit(state.copyWith(
      featured: featured,
      isValid: Formz.validate([
        state.title,
        state.description,
        state.image,
        state.video,
        state.price,
        featured,
        state.category,
      ]),
    ));
  }

  FutureOr<void> _onChangeCategory(
      ChangeCategoryEvent event, Emitter<CourseState> emit) {
    final category = FormInt.dirty(value: event.value);
    emit(state.copyWith(
      category: category,
      isValid: Formz.validate([
        state.title,
        state.description,
        state.image,
        state.video,
        state.price,
        state.featured,
        category,
      ]),
    ));
  }

  FutureOr<void> _onAddCourse(
      AddCourseEvent event, Emitter<CourseState> emit) async {
    if (state.courseStatus != CourseStatus.adding && state.isValid) {
      emit(state.copyWith(courseStatus: CourseStatus.adding));
      final response = await courseRepo.postCourse(
          data: {
            "image": MultipartFile.fromBytes(state.image.value,
                filename: "${DateTime.now().millisecondsSinceEpoch}.png"),
            "video": MultipartFile.fromBytes(
              state.video.value["byte"],
              filename: state.video.value["name"],
            ),
            "title": state.title.value,
            "desc": state.description.value,
            "price": state.price.value,
            "featured": state.featured.value,
            "category": state.category.value,
          },
          uploading: (v) {
            emit(state.copyWith(
                uploadPercentage: v, courseStatus: CourseStatus.initial));
          });
      if (response) {
        //success
        emit(state.copyWith(
          courseStatus: CourseStatus.addingSuccess,
        ));
        add(GetStartCourseEvent());
      } else {
        //fail
        emit(state.copyWith(
          courseStatus: CourseStatus.addingFail,
        ));
      }
    }
  }

  FutureOr<void> _onChangeSelectedCourse(
      ChangeSelectedCourse event, Emitter<CourseState> emit) async {
    if (event.course == null) {
      emit(state.copyWith(
        selectedCourse: null,
        clearSelectedCourse: true,
        title: const FormStringRequired.pure(),
        description: const FormStringRequired.pure(),
        image: const FormImage.pure(),
        video: const FormVideo.pure(),
        price: const FormInt.pure(),
        featured: const FormBool.pure(),
        category: const FormInt.pure(),
        courseStatus: CourseStatus.initial,
      ));
    } else {
      emit(state.copyWith(courseStatus: CourseStatus.loading));
      //
      final course = await courseRepo.getSpecificCourse(
          courseId: event.course!.id,
          progress: (v) {
            List<double> list = List.from(state.receivePercentage);
            list[0] = v;

            emit(state.copyWith(receivePercentage: list));
          });
      /* final byteImage = await fetchImage(course.image, (v) {
        List<double> list = List.from(state.receivePercentage);
        list[1] = v;
        emit(state.copyWith(receivePercentage: list));
      }); */
      /* final video = await fetchVideo(course.video ?? "", (v) {
        List<double> list = List.from(state.receivePercentage);

        list[2] = v;
        emit(state.copyWith(receivePercentage: list));
      }); */
      emit(state.copyWith(
        selectedCourse: course,
        title: FormStringRequired.dirty(value: course.title),
        description: FormStringRequired.dirty(value: course.desc ?? ""),
        image: const FormImage.dirty(value: [1]),
        video: FormVideo.dirty(value: {
          "byte": course.video,
          "name": course.video,
        }),
        price: FormInt.dirty(value: course.price ?? 0),
        featured: FormBool.dirty(value: course.featured!),
        category: FormInt.dirty(value: course.categoryId ?? -1),
        courseStatus: CourseStatus.initial,
      ));
    }
  }

  FutureOr<void> _onPostLesson(
      PostLessonEvent event, Emitter<CourseState> emit) async {
    if (!(state.courseStatus == CourseStatus.addingLesson) &&
        checkLesson(state)) {
      emit(state.copyWith(courseStatus: CourseStatus.addingLesson));

      final response = await courseRepo.postData(
        data: {
          "title": state.lessonTitle.value,
          "section": state.selectedSection!.id,
        },
        path: subsectionPath,
      );
      if (!(response == null)) {
        //subsection success
        final res = await courseRepo.postFormData(
          data: state.lessonVideo.value.isNotEmpty
              ? {
                  "video_url": MultipartFile.fromBytes(
                    state.lessonVideo.value["byte"],
                    filename: state.lessonVideo.value["name"],
                  ),
                  "subsection": response["id"],
                }
              : {
                  "pdf_url": MultipartFile.fromBytes(
                    state.lessonFile.value["byte"],
                    filename: state.lessonFile.value["name"],
                  ),
                  "subsection": response["id"],
                },
          uploading: (v) {
            log("Upload Lesson Progress: $v");
            emit(state.copyWith(uploadPercentage: v));
          },
          path: state.lessonVideo.value.isNotEmpty ? videoPath : filePath,
        );
        if (!(res == null)) {
          List<Section> sec = List.from(state.selectedCourse?.sections ?? []);
          List<SubSection> subsec =
              List.from(state.selectedSection?.subsections ?? []);
          subsec.add(
            SubSection(
              id: response["id"],
              title: response["title"],
              video: Video(
                id: res["id"],
                videoUrl: "",
                duration: "0",
                data: state.lessonVideo.value,
              ),
              pdf: Pdf(
                  id: res["id"],
                  pdfUrl: "",
                  duration: 0,
                  data: state.lessonFile.value),
            ),
          );
          final secIndex = sec
              .indexWhere((element) => element.id == state.selectedSection!.id);
          sec[secIndex] = state.selectedSection!.copyWith(subsections: subsec);

          //success
          emit(state.copyWith(
            courseStatus: CourseStatus.addingLessonSuccess,
            selectedCourse: state.selectedCourse?.copyWith(sections: sec),
            //refresh form
            selectedLesson: null,
            clearSelectedLesson: true,
            lessonTitle: FormStringRequired.pure(),
            lessonVideo: FormVideo.pure(),
            lessonFile: FormVideo.pure(),
          ));
        } else {
          //fail
          emit(state.copyWith(courseStatus: CourseStatus.addingLessonFail));
        }
      } else {
        //fail
        emit(state.copyWith(courseStatus: CourseStatus.addingLessonFail));
      }
    }
  }

  FutureOr<void> _onPostSection(
      PostSectionEvent event, Emitter<CourseState> emit) async {
    if (state.courseStatus != CourseStatus.addingSection &&
        (state.sectionTitle.value.isNotEmpty)) {
      emit(state.copyWith(courseStatus: CourseStatus.addingSection));

      final response = await courseRepo.postData(
        data: {
          "title": state.sectionTitle.value,
          "course": state.selectedCourse!.id,
        },
        path: sectionPath,
      );
      if (!(response == null)) {
        List<Section> sections =
            List.from(state.selectedCourse!.sections ?? []);
        sections.add(Section(id: response["id"], title: response["title"]));
        var course = state.selectedCourse!.copyWith(sections: sections);
        //success
        emit(
          state.copyWith(
            courseStatus: CourseStatus.addingSectionSuccess,
            selectedCourse: course,
            selectedSection: null,
            clearSelectedSection: true,
            sectionTitle: FormStringRequired.pure(),
          ),
        );
      } else {
        //fail
        emit(state.copyWith(courseStatus: CourseStatus.addingSectionFail));
      }
    }
  }

  bool checkLesson(CourseState state) {
    return state.lessonTitle.value.isNotEmpty &&
        (state.lessonVideo.value.isNotEmpty ||
            state.lessonFile.value.isNotEmpty);
  }

  FutureOr<void> _onChangeSectionTitle(
      ChangeSectionTitleEvent event, Emitter<CourseState> emit) {
    emit(state.copyWith(
      sectionTitle: FormStringRequired.dirty(value: event.value),
    ));
  }

  FutureOr<void> _onDeleteSection(
      DeleteSectionEvent event, Emitter<CourseState> emit) async {
    final response = await courseRepo.delete("$sectionPath${event.id}/");
    if (response) {
      //delete success
      List<Section> list = List.from(state.selectedCourse!.sections ?? []);
      list.removeWhere((element) => element.id == event.id);
      var course = state.selectedCourse!.copyWith(sections: list);
      emit(state.copyWith(
        courseStatus: CourseStatus.deletingSectionSuccess,
        selectedCourse: course,
      ));
    } else {
      //delete fail
      emit(state.copyWith(courseStatus: CourseStatus.deletingSectionFail));
    }
  }

  FutureOr<void> _onDeleteLesson(
      DeleteLessonEvent event, Emitter<CourseState> emit) async {
    final response = await courseRepo.delete("$subsectionPath${event.id}/");
    if (response) {
      //delete success
      List<SubSection> lessons =
          List.from(state.selectedSection!.subsections ?? []);
      lessons.removeWhere((element) => element.id == event.id);
      var section = state.selectedSection?.copyWith(subsections: lessons);
      List<Section> sections = List.from(state.selectedCourse?.sections ?? []);
      var sectionIndex =
          sections.indexWhere((element) => element.id == section!.id);
      sections[sectionIndex] = section!;
      var course = state.selectedCourse?.copyWith(sections: sections);
      emit(state.copyWith(
        courseStatus: CourseStatus.deletingLessonSuccess,
        selectedSection: section,
        selectedCourse: course,

        //refresh form
        selectedLesson: null,
        clearSelectedLesson: true,
        lessonTitle: FormStringRequired.pure(),
        lessonVideo: FormVideo.pure(),
        lessonFile: FormVideo.pure(),
      ));
    } else {
      //delete fail
      emit(state.copyWith(courseStatus: CourseStatus.deletingLessonFail));
    }
  }

  FutureOr<void> _onChangeLessonTitle(
      ChangeLessonTitleEvent event, Emitter<CourseState> emit) {
    emit(state.copyWith(
        lessonTitle: FormStringRequired.dirty(value: event.value)));
  }

  FutureOr<void> _onChangeLessonVideo(
      ChangeLessonVideoEvent event, Emitter<CourseState> emit) {
    emit(state.copyWith(lessonVideo: FormVideo.dirty(value: event.value)));
  }

  FutureOr<void> _onChangeLessonFile(
      ChangeLessonFileEvent event, Emitter<CourseState> emit) {
    emit(state.copyWith(lessonFile: FormVideo.dirty(value: event.value)));
  }

  FutureOr<void> _onChangeSelectedLesson(
      ChangeSelectedLesson event, Emitter<CourseState> emit) async {
    if (event.lesson == null) {
      //mean need to clear
      emit(
        state.copyWith(
          clearSelectedLesson: true,
          selectedLesson: null,
          //form clear
          lessonFile: FormVideo.pure(),
          lessonVideo: FormVideo.pure(),
          lessonTitle: FormStringRequired.pure(),
        ),
      );
    } else {
      //mean update
      //fetch video or file
      log("***Lesson Add: true");
      log("****SelectedLesson: ${event.lesson?.title}");
      emit(state.copyWith(
        selectedLesson: event.lesson,
        isLessonAdd: true,
        //form clear
        lessonFile: FormVideo.dirty(
            value: event.lesson?.pdf?.data ??
                (event.lesson?.pdf == null
                    ? {}
                    : {"name": event.lesson?.pdf?.pdfUrl})),
        lessonVideo: FormVideo.dirty(
            value: event.lesson?.video?.data ??
                (event.lesson?.video == null
                    ? {}
                    : {"name": event.lesson?.video?.videoUrl})),
        lessonTitle: FormStringRequired.dirty(value: event.lesson!.title),
      ));
    }
  }

  FutureOr<void> _onDeleteCourse(
      DeleteCourseEvent event, Emitter<CourseState> emit) async {
    emit(state.copyWith(courseStatus: CourseStatus.deleting));
    final response = await courseRepo.delete("$coursePath${event.id}/");
    if (response) {
      //success
      List<Course> courses = List.from(state.courses ?? []);
      courses.removeWhere((element) => element.id == event.id);
      emit(state.copyWith(
          courseStatus: CourseStatus.deletingSuccess, courses: courses));
    } else {
      emit(state.copyWith(courseStatus: CourseStatus.deletingFail));
    }
  }

  FutureOr<void> _onUpdateSection(
      UpdateSection event, Emitter<CourseState> emit) async {
    emit(state.copyWith(courseStatus: CourseStatus.updatingSection));
    final response = await courseRepo.updateData(
      data: {
        "title": state.sectionTitle.value,
        "course": state.selectedCourse!.id,
      },
      path: "$sectionPath${state.selectedSection!.id}/",
    );
    if (!(response == null)) {
      //success
      var section = Section.fromJson(response);
      List<Section> sections = List.from(state.selectedCourse!.sections ?? []);
      var index = sections
          .indexWhere((element) => element.id == state.selectedSection!.id);
      sections[index] = section;
      var course = state.selectedCourse?.copyWith(sections: sections);
      emit(state.copyWith(
        selectedCourse: course,
        courseStatus: CourseStatus.updatingSectionSuccess,
        selectedSection: null,
        clearSelectedSection: true,
        sectionTitle: FormStringRequired.pure(),
      ));
    } else {
      //fail
      emit(state.copyWith(courseStatus: CourseStatus.updatingSectionFail));
    }
  }

  FutureOr<void> _onUpdateLesson(
      UpdateLesson event, Emitter<CourseState> emit) async {
    if (!(state.courseStatus == CourseStatus.updatingLesson) &&
        checkLesson(state) &&
        (state.lessonTitle.value != state.selectedLesson!.title)) {
      emit(state.copyWith(courseStatus: CourseStatus.updatingLesson));

      final response = await courseRepo.updateData(
        data: {
          "title": state.lessonTitle.value,
          "section": state.selectedSection!.id,
        },
        path: "$subsectionPath${state.selectedLesson!.id}/",
      );
      if (!(response == null)) {
        if ((state.lessonVideo.value["name"] ==
                state.selectedLesson?.video?.videoUrl) ||
            (state.lessonFile.value["name"] ==
                state.selectedLesson?.pdf?.pdfUrl)) {
          //if same,don't need to update
          List<Section> sec = List.from(state.selectedCourse?.sections ?? []);
          List<SubSection> subsec =
              List.from(state.selectedSection?.subsections ?? []);
          int subsecIndex = subsec
              .indexWhere((element) => element.id == state.selectedLesson!.id);
          subsec[subsecIndex] = SubSection(
            id: response["id"],
            title: response["title"],
            video: state.selectedLesson?.video == null
                ? null
                : Video(
                    id: state.selectedLesson?.video?.id ?? 0,
                    videoUrl: "",
                    duration: "0",
                    data: {
                      "name": state.selectedLesson?.video?.videoUrl,
                    },
                  ),
            pdf: state.selectedLesson?.pdf == null
                ? null
                : Pdf(
                    id: state.selectedLesson?.pdf?.id ?? 0,
                    pdfUrl: "",
                    duration: 0,
                    data: {
                        "name": state.selectedLesson?.pdf?.pdfUrl,
                      }),
          );

          final secIndex = sec
              .indexWhere((element) => element.id == state.selectedSection!.id);
          sec[secIndex] = state.selectedSection!.copyWith(subsections: subsec);

          //success
          emit(state.copyWith(
            courseStatus: CourseStatus.updatingLessonSuccess,
            selectedCourse: state.selectedCourse?.copyWith(sections: sec),
            //refresh form
            selectedLesson: null,
            clearSelectedLesson: true,
            lessonTitle: FormStringRequired.pure(),
            lessonVideo: FormVideo.pure(),
            lessonFile: FormVideo.pure(),
          ));
          return;
        }
        //subsection success
        final res = await courseRepo.updateFormData(
          data: state.lessonVideo.value.isNotEmpty
              ? {
                  "video_url": MultipartFile.fromBytes(
                    state.lessonVideo.value["byte"],
                    filename: state.lessonVideo.value["name"],
                  ),
                  "subsection": response["id"],
                }
              : {
                  "pdf_url": MultipartFile.fromBytes(
                    state.lessonFile.value["byte"],
                    filename: state.lessonFile.value["name"],
                  ),
                  "subsection": response["id"],
                },
          uploading: (v) {
            log("Upload Lesson Progress: $v");
            emit(state.copyWith(uploadPercentage: v));
          },
          path: state.lessonVideo.value.isNotEmpty
              ? "$videoPath${state.selectedLesson?.video?.id}/"
              : "$filePath${state.selectedLesson?.pdf?.id}/",
        );
        if (!(res == null)) {
          List<Section> sec = List.from(state.selectedCourse?.sections ?? []);
          List<SubSection> subsec =
              List.from(state.selectedSection?.subsections ?? []);
          subsec.add(
            SubSection(
              id: response["id"],
              title: response["title"],
              video: Video(
                id: res["id"],
                videoUrl: "",
                duration: "0",
                data: state.lessonVideo.value,
              ),
              pdf: Pdf(
                  id: res["id"],
                  pdfUrl: "",
                  duration: 0,
                  data: state.lessonFile.value),
            ),
          );
          final secIndex = sec
              .indexWhere((element) => element.id == state.selectedSection!.id);
          sec[secIndex] = state.selectedSection!.copyWith(subsections: subsec);

          //success
          emit(state.copyWith(
            courseStatus: CourseStatus.updatingLessonSuccess,
            selectedCourse: state.selectedCourse?.copyWith(sections: sec),
            //refresh form
            selectedLesson: null,
            clearSelectedLesson: true,
            lessonTitle: FormStringRequired.pure(),
            lessonVideo: FormVideo.pure(),
            lessonFile: FormVideo.pure(),
          ));
        } else {
          //fail
          emit(state.copyWith(courseStatus: CourseStatus.updatingLessonFail));
        }
      } else {
        //fail
        emit(state.copyWith(courseStatus: CourseStatus.updatingLessonFail));
      }
    }
  }

  FutureOr<void> _onUpdateCourse(
      UpdateCourseEvent event, Emitter<CourseState> emit) async {
    if (state.courseStatus != CourseStatus.updating && state.isValid) {
      emit(state.copyWith(courseStatus: CourseStatus.updating));
      final data = getUpdateCourseData(state);
      final response = (data.containsKey("image") || data.containsKey("video"))
          ? await courseRepo.updateFormData(
              path: "$coursePath${state.selectedCourse!.id}/",
              data: data,
              uploading: (v) {
                emit(state.copyWith(
                    uploadPercentage: v, courseStatus: CourseStatus.initial));
              })
          : await courseRepo.updateData(
              path: "$coursePath${state.selectedCourse!.id}/",
              data: data,
            );
      if (!(response == null)) {
        //success
        emit(state.copyWith(
          courseStatus: CourseStatus.updatingSuccess,
        ));
        add(GetStartCourseEvent());
      } else {
        //fail
        emit(state.copyWith(
          courseStatus: CourseStatus.updatingFail,
        ));
      }
    }
  }

  Map<String, dynamic> getUpdateCourseData(CourseState state) {
    if ((state.image.value.length == 1 &&
        state.video.value["name"] != state.selectedCourse!.video)) {
      //just remove image
      return {
        "video": MultipartFile.fromBytes(
          state.video.value["byte"],
          filename: state.video.value["name"],
        ),
        "title": state.title.value,
        "desc": state.description.value,
        "price": state.price.value,
        "featured": state.featured.value,
        "category": state.category.value,
      };
    } else if ((state.image.value.length != 1 &&
        state.video.value["name"] == state.selectedCourse!.video)) {
      //just remove video
      return {
        "image": MultipartFile.fromBytes(state.image.value,
            filename: "${DateTime.now().millisecondsSinceEpoch}.png"),
        "title": state.title.value,
        "desc": state.description.value,
        "price": state.price.value,
        "featured": state.featured.value,
        "category": state.category.value,
      };
    } else if ((state.image.value.length == 1 &&
        state.video.value["name"] == state.selectedCourse!.video)) {
      //remove image & video
      return {
        "title": state.title.value,
        "desc": state.description.value,
        "price": state.price.value,
        "featured": state.featured.value,
        "category": state.category.value,
      };
    } else {
      //can't remove image & video
      return {
        "image": MultipartFile.fromBytes(state.image.value,
            filename: "${DateTime.now().millisecondsSinceEpoch}.png"),
        "video": MultipartFile.fromBytes(
          state.video.value["byte"],
          filename: state.video.value["name"],
        ),
        "title": state.title.value,
        "desc": state.description.value,
        "price": state.price.value,
        "featured": state.featured.value,
        "category": state.category.value,
      };
    }
  }

  FutureOr<void> _onSearchCourse(
      SearchCourse event, Emitter<CourseState> emit) async {
    if (state.courseStatus != CourseStatus.searching) {
      //search
      final response =
          await courseRepo.searchCourse(path: coursePath, data: event.value);
      if (response.error == null) {
        //success
        emit(state.copyWith(
          courseStatus: CourseStatus.searchingSuccess,
          hasMore: response.next == null ? false : true,
          next: response.next,
          courses: response.results,
        ));
      } else {
        //fail
        emit(state.copyWith(
          courseStatus: CourseStatus.searchingFail,
          error: response.error?.detail,
        ));
      }
    }
  }
}
