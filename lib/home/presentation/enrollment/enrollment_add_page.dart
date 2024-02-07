import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mmlearning_admin/app_icon.dart';
import 'package:mmlearning_admin/bloc/bloc/course_bloc.dart';
import 'package:mmlearning_admin/bloc/bloc/enrollment_bloc.dart';
import 'package:mmlearning_admin/bloc/bloc/student_bloc.dart';
import 'package:mmlearning_admin/bloc/core_bloc.dart';
import 'package:mmlearning_admin/constant.dart';
import 'package:mmlearning_admin/extension_widget.dart';
import 'package:mmlearning_admin/home/presentation/widget/loading_widget.dart';

class EnrollmentAddPage extends StatelessWidget {
  const EnrollmentAddPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    return Scaffold(
      floatingActionButton: SizedBox(
        width: 140,
        height: 38,
        child: FloatingActionButton(
          backgroundColor: primaryColor,
          onPressed: () {
            context.read<EnrollmentBloc>().add(AddEnrollment());
          },
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          child: Builder(builder: (context) {
            final status = context
                .select((EnrollmentBloc bloc) => bloc.state.enrollmentStatus);
            return status == EnrollmentStatus.adding
                ? const LoadingWidget(
                    color: Colors.white,
                  )
                : Text(
                    "SAVE",
                    style: textTheme.bodySmall?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  );
          }),
        ),
      ),
      body: Card(
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
                    "Add Enrollment",
                    style: textTheme.displayLarge,
                  ),
                ],
              ),
              20.v(),

              Text("Choose Course", style: textTheme.displayLarge)
                  .withPaddingOnly(left: 40),
              10.v(),
              Builder(builder: (context) {
                final courseId = context
                    .select((EnrollmentBloc bloc) => bloc.state.courseId);
                final courses =
                    context.select((CourseBloc bloc) => bloc.state.courses);
                return Wrap(
                  children: (courses ?? [])
                      .map((e) => InkWell(
                          onTap: () => context
                              .read<EnrollmentBloc>()
                              .add(ChangeCourseId(id: e.id)),
                          child: Container(
                            margin: const EdgeInsets.symmetric(
                                horizontal: 5, vertical: 4),
                            decoration: BoxDecoration(
                              color: courseId.value == e.id
                                  ? primaryColor
                                  : Colors.white,
                              border: Border.all(
                                color: Colors.grey,
                                width: 2,
                              ),
                              borderRadius: const BorderRadius.all(
                                Radius.circular(20),
                              ),
                            ),
                            padding: const EdgeInsets.only(
                                left: 20, right: 20, top: 10, bottom: 10),
                            child: Text(
                              e.title,
                              style: textTheme.displaySmall?.copyWith(
                                color: courseId.value == e.id
                                    ? Colors.white
                                    : null,
                              ),
                            ),
                          )))
                      .toList(),
                ).withPaddingOnly(left: 40, right: 20);
              }),
              20.v(),
              //choose student
              Text("Choose Student", style: textTheme.displayLarge)
                  .withPaddingOnly(left: 40),
              10.v(),
              Builder(builder: (context) {
                final studentId = context
                    .select((EnrollmentBloc bloc) => bloc.state.studentId);
                final students =
                    context.select((StudentBloc bloc) => bloc.state.students);
                return Wrap(
                  children: (students ?? [])
                      .map((e) => InkWell(
                            onTap: () => context
                                .read<EnrollmentBloc>()
                                .add(ChangeStudentId(id: e.id)),
                            child: Container(
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 5, vertical: 4),
                              decoration: BoxDecoration(
                                color: studentId.value == e.id
                                    ? primaryColor
                                    : Colors.white,
                                border: Border.all(
                                  color: Colors.grey,
                                  width: 2,
                                ),
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(20),
                                ),
                              ),
                              padding: const EdgeInsets.only(
                                  left: 20, right: 20, top: 10, bottom: 10),
                              child: Text(
                                "${e.user.firstName} ${e.user.lastName}",
                                style: textTheme.displaySmall?.copyWith(
                                  color: studentId.value == e.id
                                      ? Colors.white
                                      : null,
                                ),
                              ),
                            ),
                          ))
                      .toList(),
                ).withPaddingOnly(left: 40, right: 20);
              }),
            ],
          ),
        ).withPadding(h: 10, v: 10),
      ),
    ).withPaddingOnly(right: 20) /* .withPadding(h: 20, v: 0) */;
  }
}
