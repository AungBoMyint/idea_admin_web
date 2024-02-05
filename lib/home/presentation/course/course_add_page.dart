import 'dart:developer';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:html_editor_enhanced/html_editor.dart';
import 'package:mmlearning_admin/app_icon.dart';
import 'package:mmlearning_admin/app_image.dart';
import 'package:mmlearning_admin/bloc/bloc/category_bloc.dart';
import 'package:mmlearning_admin/bloc/bloc/course_bloc.dart';
import 'package:mmlearning_admin/bloc/core_bloc.dart';
import 'package:mmlearning_admin/constant.dart';
import 'package:mmlearning_admin/extension_widget.dart';
import 'package:mmlearning_admin/function.dart';
import 'package:mmlearning_admin/home/presentation/widget/loading_widget.dart';
import 'package:mmlearning_admin/home/presentation/widget/video_widget.dart';
import 'package:mmlearning_admin/mock.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:video_player/video_player.dart';

import 'course_form_widget.dart';
import 'edit_delete_row.dart';
import 'lesson_form_widget.dart';
import 'section_form_widget.dart';

class CourseAddPage extends StatelessWidget {
  const CourseAddPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    final size = MediaQuery.of(context).size;
    return Scaffold(
      floatingActionButton: SizedBox(
        width: 140,
        height: 38,
        child: Builder(builder: (context) {
          final courseStatus =
              context.select((CourseBloc bloc) => bloc.state.courseStatus);
          final selectedCourse =
              context.select((CourseBloc bloc) => bloc.state.selectedCourse);
          return FloatingActionButton(
            backgroundColor: primaryColor,
            onPressed: () {
              if (selectedCourse == null) {
                //mean upload
                context.read<CourseBloc>().add(AddCourseEvent());
              } else {
                //mean update
                context.read<CourseBloc>().add(UpdateCourseEvent());
              }
            },
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            child: courseStatus == CourseStatus.adding ||
                    courseStatus == CourseStatus.updating
                ? const LoadingWidget(
                    color: Colors.white,
                  )
                : Text(
                    selectedCourse == null ? "SAVE" : "UPDATE",
                    style: textTheme.bodySmall?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
          );
        }),
      ),
      body: Builder(builder: (context) {
        final receiveProgress =
            context.select((CourseBloc bloc) => bloc.state.receivePercentage);
        final courseStatus =
            context.select((CourseBloc bloc) => bloc.state.courseStatus);
        if (courseStatus == CourseStatus.loading) {
          final averageProgress =
              receiveProgress.fold(0.0, (acc, current) => acc + current);

          return const LoadingWidget(); /* Center(
            child: SizedBox(
              width: size.width * 0.25,
              child: LinearPercentIndicator(
                animation: true,
                lineHeight: 15.0,
                barRadius: Radius.circular(10),
                animationDuration: 0,
                percent: (averageProgress / 2),
                center: Text(
                  "${((averageProgress / 2) * 100).round()}%",
                  style: textTheme.bodySmall?.copyWith(
                    color: (averageProgress / 2) > 0.5
                        ? Colors.white
                        : Colors.black,
                  ),
                ),
                leading: Text(
                  "Fetching....",
                  style: textTheme.bodySmall,
                ),
                linearStrokeCap: LinearStrokeCap.round,
                progressColor: primaryColor,
              ),
            ),
          ); */

          /*  return const LoadingWidget(); */
        }
        return Card(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                20.v(),
                //appbar
                Row(
                  children: [
                    InkWell(
                      onTap: () => context.read<CoreBloc>().add(
                          ChangeDetailPageEvent(detailPage: DetailPage.empty)),
                      child: Image.asset(
                        AppIcon.backArrow,
                        width: 30,
                        height: 30,
                      ),
                    ),
                    10.h(),
                    Text(
                      "Add Course",
                      style: textTheme.displayLarge,
                    ),
                  ],
                ),
                20.v(),
                const CourseFormWidget(),
                //Sections & Lessons

                Builder(builder: (context) {
                  final selectedCourse = context
                      .select((CourseBloc bloc) => bloc.state.selectedCourse);
                  if (selectedCourse == null) {
                    return 0.h();
                  }
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      20.v(),
                      Row(
                        children: [
                          Text("Sections:", style: textTheme.displayLarge),
                          10.h(),
                          InkWell(
                            onTap: () => context
                                .read<CourseBloc>()
                                .add(ChangeSectionAdd()),
                            child: Image.asset(
                              AppIcon.add,
                              height: 28,
                              width: 28,
                            ),
                          ),
                        ],
                      ),
                      10.v(),
                      const SectionFormWidget(),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: (selectedCourse.sections ?? [])
                            .map((e) => Builder(builder: (context) {
                                  final selectedSection = context.select(
                                      (CourseBloc bloc) =>
                                          bloc.state.selectedSection);
                                  return InkWell(
                                    onTap: () {
                                      //admin
                                      context
                                          .read<CourseBloc>()
                                          .add(ChangeSelectedSection(
                                            section: e,
                                          ));
                                    },
                                    child: Card(
                                      color: Colors.white,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          EditDeleteTextRow(
                                            onDelete: () => context
                                                .read<CourseBloc>()
                                                .add(DeleteSectionEvent(
                                                    id: e.id)),
                                            onEdit: () {
                                              context.read<CourseBloc>().add(
                                                  ChangeSelectedSection(
                                                      section: e));
                                            },
                                            data: e.title,
                                            isSelected:
                                                selectedSection?.id == e.id,
                                          ),
                                          //Lessons
                                          selectedSection?.id == e.id
                                              ? Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Divider(),
                                                    Row(
                                                      children: [
                                                        Text("Lessons:",
                                                            style: textTheme
                                                                .displayLarge),
                                                        10.h(),
                                                        InkWell(
                                                          onTap: () => context
                                                              .read<
                                                                  CourseBloc>()
                                                              .add(
                                                                  ChangeLessonAdd()),
                                                          child: Image.asset(
                                                            AppIcon.add,
                                                            height: 28,
                                                            width: 28,
                                                          ),
                                                        ),
                                                      ],
                                                    ).withPaddingOnly(left: 20),
                                                    10.v(),
                                                    const LessonFormWidget(),
                                                    10.v(),
                                                    Column(
                                                      children: (e.subsections ??
                                                              [])
                                                          .map((childE) =>
                                                              EditDeleteTextRow(
                                                                onEdit: () {
                                                                  context
                                                                      .read<
                                                                          CourseBloc>()
                                                                      .add(ChangeSelectedLesson(
                                                                          lesson:
                                                                              childE));
                                                                },
                                                                onDelete: () => context
                                                                    .read<
                                                                        CourseBloc>()
                                                                    .add(DeleteLessonEvent(
                                                                        id: childE
                                                                            .id)),
                                                                data: childE
                                                                    .title,
                                                                hasArrow: false,
                                                                isSelected:
                                                                    selectedSection
                                                                            ?.id ==
                                                                        childE
                                                                            .id,
                                                              ))
                                                          .toList(),
                                                    ).withPaddingOnly(left: 20),
                                                  ],
                                                )
                                              : 0.h(),
                                        ],
                                      ).withPadding(h: 0, v: 5),
                                    ),
                                  );
                                }))
                            .toList(),
                      ).withPaddingOnly(right: 20),
                    ],
                  ).withPaddingOnly(left: 40);
                }),
              ],
            ),
          ).withPadding(h: 10, v: 10),
        );
      }),
    ).withPaddingOnly(right: 20) /* .withPadding(h: 20, v: 0) */;
  }
}
