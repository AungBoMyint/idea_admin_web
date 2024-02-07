import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:html_editor_enhanced/html_editor.dart';
import 'package:mmlearning_admin/app_icon.dart';
import 'package:mmlearning_admin/app_image.dart';
import 'package:mmlearning_admin/bloc/bloc/review_bloc.dart';
import 'package:mmlearning_admin/bloc/core_bloc.dart';
import 'package:mmlearning_admin/constant.dart';
import 'package:mmlearning_admin/extension_widget.dart';
import 'package:mmlearning_admin/home/presentation/widget/loading_widget.dart';
import 'package:mmlearning_admin/mock.dart';

import '../../../bloc/bloc/course_bloc.dart';
import '../../../bloc/bloc/student_bloc.dart';

class ReviewAddPage extends StatelessWidget {
  const ReviewAddPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final border = OutlineInputBorder(
      borderSide: BorderSide(
        color: primaryColor,
        width: 3,
      ),
    );
    final size = MediaQuery.of(context).size;
    return Scaffold(
      floatingActionButton: SizedBox(
        width: 140,
        height: 38,
        child: Builder(builder: (context) {
          final selectedReview =
              context.select((ReviewBloc bloc) => bloc.state.selectedReview);
          final status =
              context.select((ReviewBloc bloc) => bloc.state.reviewStatus);
          return FloatingActionButton(
            backgroundColor: primaryColor,
            onPressed: () {
              if (selectedReview == null) {
                //upload
                context.read<ReviewBloc>().add(AddReview());
              } else {
                context.read<ReviewBloc>().add(UpdateReview());
              }
            },
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            child:
                status == ReviewStatus.adding || status == ReviewStatus.updating
                    ? const LoadingWidget(
                        color: Colors.white,
                      )
                    : Text(
                        selectedReview == null ? "SAVE" : "UPDATE",
                        style: textTheme.bodySmall?.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
          );
        }),
      ),
      body: Builder(builder: (context) {
        final status =
            context.select((ReviewBloc bloc) => bloc.state.reviewStatus);
        return status == ReviewStatus.loading
            ? const LoadingWidget()
            : Card(
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
                                ChangeDetailPageEvent(
                                    detailPage: DetailPage.empty)),
                            child: Image.asset(
                              AppIcon.backArrow,
                              width: 30,
                              height: 30,
                            ),
                          ),
                          10.h(),
                          Text(
                            "Add Review",
                            style: textTheme.displayLarge,
                          ),
                        ],
                      ),
                      20.v(),
                      //Title
                      SizedBox(
                        width: size.width * 0.4,
                        child: Builder(builder: (context) {
                          final review = context
                              .select((ReviewBloc bloc) => bloc.state.review);
                          return TextFormField(
                            autofocus: true,
                            initialValue: review.value,
                            onChanged: (v) => context
                                .read<ReviewBloc>()
                                .add(ChangeReview(value: v)),
                            decoration: InputDecoration(
                              border: border,
                              focusedBorder: border,
                              enabledBorder: border,
                              disabledBorder: border,
                              labelText: "Review",
                              floatingLabelStyle: textTheme.displayLarge,
                            ),
                          );
                        }),
                      ).withPadding(h: 40, v: 0),
                      20.v(),
                      Text("Choose Course", style: textTheme.displayLarge)
                          .withPaddingOnly(left: 40),
                      10.v(),
                      Builder(builder: (context) {
                        final courseId = context
                            .select((ReviewBloc bloc) => bloc.state.courseId);
                        final courses = context
                            .select((CourseBloc bloc) => bloc.state.courses);
                        return Wrap(
                          children: (courses ?? [])
                              .map((e) => InkWell(
                                    onTap: () => context
                                        .read<ReviewBloc>()
                                        .add(ChangeCourseId(value: e.id)),
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
                                          left: 20,
                                          right: 20,
                                          top: 10,
                                          bottom: 10),
                                      child: Text(
                                        e.title,
                                        style: textTheme.displaySmall?.copyWith(
                                          color: courseId.value == e.id
                                              ? Colors.white
                                              : null,
                                        ),
                                      ),
                                    ),
                                  ))
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
                            .select((ReviewBloc bloc) => bloc.state.studentId);
                        final students = context
                            .select((StudentBloc bloc) => bloc.state.students);
                        return Wrap(
                          children: (students ?? [])
                              .map((e) => InkWell(
                                    onTap: () => context
                                        .read<ReviewBloc>()
                                        .add(ChangeStudentId(value: e.id)),
                                    child: Container(
                                      margin: EdgeInsets.symmetric(
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
                                          left: 20,
                                          right: 20,
                                          top: 10,
                                          bottom: 10),
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
                      })
                    ],
                  ),
                ).withPadding(h: 10, v: 10),
              );
      }),
    ).withPaddingOnly(right: 20) /* .withPadding(h: 20, v: 0) */;
  }
}
