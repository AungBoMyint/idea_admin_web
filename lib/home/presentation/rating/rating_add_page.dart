import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:html_editor_enhanced/html_editor.dart';
import 'package:mmlearning_admin/app_icon.dart';
import 'package:mmlearning_admin/app_image.dart';
import 'package:mmlearning_admin/bloc/bloc/course_bloc.dart';
import 'package:mmlearning_admin/bloc/bloc/rating_bloc.dart';
import 'package:mmlearning_admin/bloc/bloc/student_bloc.dart';
import 'package:mmlearning_admin/bloc/core_bloc.dart';
import 'package:mmlearning_admin/constant.dart';
import 'package:mmlearning_admin/extension_widget.dart';
import 'package:mmlearning_admin/home/presentation/widget/loading_widget.dart';
import 'package:mmlearning_admin/mock.dart';

class RatingAddPage extends StatelessWidget {
  const RatingAddPage({super.key});

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
          final selectedRating =
              context.select((RatingBloc bloc) => bloc.state.selectedRating);
          final status =
              context.select((RatingBloc bloc) => bloc.state.ratingStatus);
          return FloatingActionButton(
            backgroundColor: primaryColor,
            onPressed: () {
              if (selectedRating == null) {
                //adding rating
                context.read<RatingBloc>().add(AddRating());
              } else {
                //updating rating
                context.read<RatingBloc>().add(UpdateRating());
              }
            },
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            child:
                status == RatingStatus.adding || status == RatingStatus.updating
                    ? const LoadingWidget(
                        color: Colors.white,
                      )
                    : Text(
                        selectedRating == null ? "SAVE" : "UPDATE",
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
            context.select((RatingBloc bloc) => bloc.state.ratingStatus);
        return status == RatingStatus.loading
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
                            "Add Rating",
                            style: textTheme.displayLarge,
                          ),
                        ],
                      ),
                      20.v(),
                      //Title
                      SizedBox(
                        width: size.width * 0.4,
                        child: Builder(builder: (context) {
                          final rating = context
                              .select((RatingBloc bloc) => bloc.state.rating);
                          return TextFormField(
                            initialValue: rating.value.toString(),
                            autofocus: true,
                            onChanged: (v) => context.read<RatingBloc>().add(
                                ChangeRating(value: double.tryParse(v) ?? 0)),
                            decoration: InputDecoration(
                              border: border,
                              focusedBorder: border,
                              enabledBorder: border,
                              disabledBorder: border,
                              labelText: "Rating",
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
                            .select((RatingBloc bloc) => bloc.state.courseId);
                        final courses = context
                            .select((CourseBloc bloc) => bloc.state.courses);
                        return Wrap(
                          children: (courses ?? [])
                              .map((e) => InkWell(
                                  onTap: () => context
                                      .read<RatingBloc>()
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
                                      borderRadius: BorderRadius.all(
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
                            .select((RatingBloc bloc) => bloc.state.studentId);
                        final students = context
                            .select((StudentBloc bloc) => bloc.state.students);
                        return Wrap(
                          children: (students ?? [])
                              .map((e) => InkWell(
                                    onTap: () => context
                                        .read<RatingBloc>()
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
                                        borderRadius: BorderRadius.all(
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
                      }),
                    ],
                  ),
                ).withPadding(h: 10, v: 10),
              );
      }),
    ).withPaddingOnly(right: 20) /* .withPadding(h: 20, v: 0) */;
  }
}
