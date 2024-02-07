import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mmlearning_admin/extension_widget.dart';

import '../../../app_icon.dart';
import '../../../bloc/bloc/course_bloc.dart';
import '../../../constant.dart';
import '../../../function.dart';
import '../widget/loading_widget.dart';

class LessonFormWidget extends StatelessWidget {
  const LessonFormWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    return BlocBuilder<CourseBloc, CourseState>(
      builder: (context, state) {
        log("Lesson State Change: ${state.isLessonAdd}");
        if (state.isLessonAdd == false) {
          return 0.h();
        }
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //
            Row(
              children: [
                SizedBox(
                  width: size.width * 0.4,
                  child: TextFormField(
                    initialValue: state.lessonTitle.value,
                    onChanged: (v) => context
                        .read<CourseBloc>()
                        .add(ChangeLessonTitleEvent(value: v)),
                    decoration: InputDecoration(
                      border: border,
                      focusedBorder: border,
                      enabledBorder: border,
                      disabledBorder: border,
                      labelText: "Lesson title",
                      floatingLabelStyle: textTheme.displayLarge,
                    ),
                  ),
                ),
                10.v(),
                IconButton(
                    onPressed: () =>
                        context.read<CourseBloc>().add(ChangeLessonAdd()),
                    icon: const Icon(
                      Icons.remove,
                      color: Colors.red,
                    ))
              ],
            ),
            10.v(),
            SizedBox(
              width: size.width * 0.4,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Container(
                        width: 180,
                        color: Colors.white,
                        padding: const EdgeInsets.all(10),
                        child: Builder(builder: (context) {
                          if (state.lessonVideo.value.isNotEmpty) {
                            return Text(
                              state.lessonVideo.value["name"],
                              style: textTheme.bodySmall,
                              maxLines: 5,
                            );
                          }
                          return Image.asset(
                            AppIcon.video,
                            height: 80,
                            width: 80,
                          );
                        }),
                      ),
                      20.v(),
                      ElevatedButton(
                        onPressed: () => pickVideo().then((value) {
                          if (!(value == null)) {
                            context
                                .read<CourseBloc>()
                                .add(ChangeLessonVideoEvent(value: value));
                          }
                        }),
                        child: Text(
                          "Choose Video",
                          style: theme.textTheme.displayMedium?.copyWith(
                            color: Colors.white,
                          ),
                        ),
                      ).withDefault(
                        radius: 10,
                        height: 35,
                        width: 180,
                      ),
                    ],
                  ),
                  Text(
                    "OR",
                    style: textTheme.displaySmall,
                  ),
                  //pdf-file
                  Column(
                    children: [
                      Container(
                        width: 180,
                        color: Colors.white,
                        padding: const EdgeInsets.all(10),
                        child: Builder(builder: (context) {
                          if (state.lessonFile.value.isNotEmpty) {
                            return Text(
                              state.lessonFile.value["name"],
                              style: textTheme.bodySmall,
                              maxLines: 5,
                            );
                          }
                          return Image.asset(
                            AppIcon.pdf,
                            height: 80,
                            width: 80,
                          );
                        }),
                      ),
                      20.v(),
                      ElevatedButton(
                        onPressed: () => pickFile().then((value) {
                          if (!(value == null)) {
                            context.read<CourseBloc>().add(
                                  ChangeLessonFileEvent(value: value),
                                );
                          }
                        }),
                        child: Text(
                          "Choose File",
                          style: theme.textTheme.displayMedium?.copyWith(
                            color: Colors.white,
                          ),
                        ),
                      ).withDefault(
                        radius: 10,
                        height: 35,
                        width: 180,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            10.v(),
            //
            ElevatedButton(
              onPressed: () {
                if (state.selectedLesson == null) {
                  context.read<CourseBloc>().add(PostLessonEvent());
                } else {
                  context.read<CourseBloc>().add(UpdateLesson());
                }
              },
              child: state.courseStatus == CourseStatus.addingLesson ||
                      state.courseStatus == CourseStatus.updatingLesson
                  ? const LoadingWidget(
                      color: Colors.white,
                    )
                  : Text(
                      state.selectedLesson == null ? "Add" : "Update",
                      style: theme.textTheme.displayMedium?.copyWith(
                        color: Colors.white,
                      ),
                    ),
            ).withDefault(
              radius: 10,
              height: 35,
              width: size.width * 0.4,
            ),
          ],
        ).withPaddingOnly(left: 40);
      },
    );
  }
}
