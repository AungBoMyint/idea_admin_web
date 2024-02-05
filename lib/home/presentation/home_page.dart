import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mmlearning_admin/app_icon.dart';
import 'package:mmlearning_admin/app_image.dart';
import 'package:mmlearning_admin/bloc/bloc/course_bloc.dart';
import 'package:mmlearning_admin/bloc/core_bloc.dart';
import 'package:mmlearning_admin/constant.dart';
import 'package:mmlearning_admin/core/presentation/responsive_builder.dart';
import 'package:mmlearning_admin/core/presentation/responsive_widget.dart';
import 'package:mmlearning_admin/dimension.dart';
import 'package:mmlearning_admin/extension_widget.dart';
import 'package:mmlearning_admin/home/presentation/category/category_add_page.dart';
import 'package:mmlearning_admin/home/presentation/category/category_list_page.dart';
import 'package:mmlearning_admin/home/presentation/course/course_add_page.dart';
import 'package:mmlearning_admin/home/presentation/discount/discount_list_page.dart';
import 'package:mmlearning_admin/home/presentation/enrollment/enrollment_add_page.dart';
import 'package:mmlearning_admin/home/presentation/enrollment/enrollment_list_page.dart';
import 'package:mmlearning_admin/home/presentation/rating/rating_add_page.dart';
import 'package:mmlearning_admin/home/presentation/rating/rating_list_page.dart';
import 'package:mmlearning_admin/home/presentation/review/review_add_page.dart';
import 'package:mmlearning_admin/home/presentation/review/review_list_page.dart';
import 'package:mmlearning_admin/home/presentation/slider/slider_add_page.dart';
import 'package:mmlearning_admin/home/presentation/slider/slider_list_page.dart';
import 'package:mmlearning_admin/home/presentation/student/student_add_page.dart';
import 'package:mmlearning_admin/home/presentation/student/student_list_page.dart';
import 'package:mmlearning_admin/main.dart';
import 'package:percent_indicator/percent_indicator.dart';

import 'course/course_list_page.dart';
import 'discount/discount_add_page.dart';
import 'widget/custom_app_bar.dart';
import 'widget/drawer_mobile.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    const border = OutlineInputBorder(
      borderSide: BorderSide(
        color: Colors.black,
      ),
    );
    final size = MediaQuery.of(context).size;
    return Scaffold(
      key: scaffoldKey,
      drawer: Drawermobile(textTheme: textTheme),
      appBar: size.width >= DESKTOP ? null : CustomAppBar(),
      body: Stack(
        children: [
          BlocBuilder<CoreBloc, CoreState>(
            builder: (context, state) {
              if (state.detailPage != DetailPage.empty) {
                return ResponsiveBuilder(builder: (status) {
                  return Row(
                    children: [
                      status == SizeStatus.desktop
                          ? Expanded(
                              child: Drawermobile(textTheme: textTheme),
                            )
                          : const SizedBox(),
                      status == SizeStatus.desktop ? 20.h() : const SizedBox(),
                      Expanded(
                        flex: 4,
                        child: getWidget(state.detailPage),
                      ),
                    ],
                  );
                });
              }
              //for home
              return [
                //Category
                CategoryListPage(),
                //Slider
                SliderListPage(),
                //Courses
                CourseListPage(),
                //Sections
                //Container(),
                //Discount
                DiscountListPage(),
                //Students
                StudentListPage(),
                //Enrollment
                EnrollmentListPage(),
                //Rating
                RatingListPage(),
                //Review
                ReviewListPage(),
              ][state.page];
            },
          ),
          Positioned(
            top: 0,
            right: 20,
            child: Builder(builder: (context) {
              final courseStatus =
                  context.select((CourseBloc bloc) => bloc.state.courseStatus);
              final percent = context
                  .select((CourseBloc bloc) => bloc.state.uploadPercentage);
              return ((percent != 1.0) && (percent != 0.0000000))
                  ? SizedBox(
                      height: 70,
                      width: (size.width * 0.5),
                      child: Card(
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                        courseStatus ==
                                                CourseStatus.addingLesson
                                            ? "Lesson uploading"
                                            : courseStatus ==
                                                    CourseStatus.updating
                                                ? "Course updating...."
                                                : "Course uploading....",
                                        style:
                                            textTheme.displayMedium?.copyWith(
                                          fontWeight: FontWeight.w800,
                                          color: primaryColor,
                                        )).withPaddingOnly(left: 10),
                                    8.v(),
                                    LinearPercentIndicator(
                                      animation: true,
                                      lineHeight: 10.0,
                                      barRadius: Radius.circular(10),
                                      animationDuration: 0,
                                      percent: percent,
                                      linearStrokeCap: LinearStrokeCap.round,
                                      progressColor: primaryColor,
                                    ),
                                  ],
                                ),
                              ),
                              5.h(),
                              //percentage
                              CircleAvatar(
                                radius: 18,
                                backgroundColor: Colors.grey.shade300,
                                child: Center(
                                  child: Text(
                                    "${(percent * 100).round()}%",
                                    style: textTheme.bodySmall?.copyWith(
                                      color: primaryColor,
                                      fontSize: 10,
                                      fontWeight: FontWeight.w900,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                  : 0.h();
            }),
          ),
        ],
      ),
    );
  }

  getWidget(DetailPage detailPage) {
    switch (detailPage) {
      case DetailPage.categoryAdd:
        return CategoryAddPage();
      case DetailPage.sliderAdd:
        return SliderAddPage();
      case DetailPage.courseAdd:
        return CourseAddPage();
      case DetailPage.discountAdd:
        return DiscountAddPage();
      case DetailPage.studentAdd:
        return StudentAddPage();
      case DetailPage.enrollmentAdd:
        return EnrollmentAddPage();
      case DetailPage.ratingAdd:
        return RatingAddPage();
      case DetailPage.reviewAdd:
        return ReviewAddPage();
      default:
        return Container();
    }
  }
}
