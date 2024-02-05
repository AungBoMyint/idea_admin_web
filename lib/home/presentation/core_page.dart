import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mmlearning_admin/bloc/bloc/auth_bloc.dart';
import 'package:mmlearning_admin/bloc/bloc/category_bloc.dart';
import 'package:mmlearning_admin/bloc/bloc/course_bloc.dart';
import 'package:mmlearning_admin/bloc/bloc/discount_bloc.dart';
import 'package:mmlearning_admin/bloc/bloc/slider_bloc.dart';
import 'package:mmlearning_admin/enum_class.dart';
import 'package:mmlearning_admin/home/presentation/home_page.dart';
import 'package:mmlearning_admin/home/presentation/signin/signin_page.dart';

import '../../bloc/bloc/student_bloc.dart';
import '../../function.dart';

class CorePage extends StatelessWidget {
  const CorePage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<CategoryBloc, CategoryState>(
            listenWhen: (previous, current) =>
                previous.categoryStatus != current.categoryStatus,
            listener: (context, state) {
              switch (state.categoryStatus) {
                //Success
                case CategoryStatus.addingSuccess:
                  showSuccessSnack(
                      context: context,
                      data: "Category Uploading is successful!");
                  break;
                case CategoryStatus.updatingSuccess:
                  showSuccessSnack(
                      context: context,
                      data: "Category Updating is successful!");
                  break;
                case CategoryStatus.deletingSuccess:
                  showSuccessSnack(
                      context: context,
                      data: "Category Deleting is successful!");
                  break;
                //Fail
                case CategoryStatus.addingFail:
                  showErrorSnack(
                      context: context, data: "Category Uploading is failed!");
                  break;
                case CategoryStatus.updatingFail:
                  showErrorSnack(
                      context: context, data: "Category Updating is failed!");
                  break;
                case CategoryStatus.deletingFail:
                  showErrorSnack(
                      context: context, data: "Category Deleting is failed!");
                  break;
                default:
              }
            }),
        //Slider
        BlocListener<SliderBloc, SliderState>(
            listenWhen: (previous, current) =>
                previous.sliderStatus != current.sliderStatus,
            listener: (context, state) {
              switch (state.sliderStatus) {
                //Success
                case SliderStatus.addingSuccess:
                  showSuccessSnack(
                      context: context,
                      data: "Slider Uploading is successful!");
                  break;
                case SliderStatus.updatingSuccess:
                  showSuccessSnack(
                      context: context, data: "Slider Updating is successful!");
                  break;
                case SliderStatus.deletingSuccess:
                  showSuccessSnack(
                      context: context, data: "Slider Deleting is successful!");
                  break;
                //Fail
                case SliderStatus.addingFail:
                  showErrorSnack(
                      context: context, data: "Slider Uploading is failed!");
                  break;
                case SliderStatus.updatingFail:
                  showErrorSnack(
                      context: context, data: "Slider Updating is failed!");
                  break;
                case SliderStatus.deletingFail:
                  showErrorSnack(
                      context: context, data: "Slider Deleting is failed!");
                  break;
                default:
              }
            }),
        //Course
        BlocListener<CourseBloc, CourseState>(
            listenWhen: (previous, current) =>
                previous.courseStatus != current.courseStatus,
            listener: (context, state) {
              switch (state.courseStatus) {
                //lesson
                case CourseStatus.addingLessonSuccess:
                  showSuccessSnack(
                      context: context,
                      data: "Lesson Uploading is successful!");
                  break;
                case CourseStatus.addingLessonFail:
                  showErrorSnack(
                      context: context, data: "Lesson Uploading is failed!");
                  break;
                case CourseStatus.updatingLessonSuccess:
                  showSuccessSnack(
                      context: context, data: "Lesson updating is successful!");
                  break;
                case CourseStatus.updatingLessonFail:
                  showErrorSnack(
                      context: context, data: "Lesson updating is failed!");
                  break;
                case CourseStatus.deletingLessonSuccess:
                  showSuccessSnack(
                      context: context, data: "Lesson deleting is successful!");
                  break;
                case CourseStatus.deletingLessonFail:
                  showErrorSnack(
                      context: context, data: "Lesson deleting is failed!");
                  break;

                //Section
                case CourseStatus.addingSectionSuccess:
                  showSuccessSnack(
                      context: context,
                      data: "Section Uploading is successful!");
                  break;
                case CourseStatus.addingSectionFail:
                  showErrorSnack(
                      context: context, data: "Section Uploading is failed!");
                  break;
                case CourseStatus.deletingSectionSuccess:
                  showSuccessSnack(
                      context: context,
                      data: "Section deleting is successful!");
                  break;
                case CourseStatus.deletingSectionFail:
                  showErrorSnack(
                      context: context, data: "Section deleting is failed!");
                  break;
                //Success
                case CourseStatus.addingSuccess:
                  showSuccessSnack(
                      context: context,
                      data: "Course Uploading is successful!");
                  break;
                case CourseStatus.updatingSuccess:
                  showSuccessSnack(
                      context: context, data: "Course Updating is successful!");
                  break;
                case CourseStatus.deletingSuccess:
                  showSuccessSnack(
                      context: context, data: "Course Deleting is successful!");
                  break;
                //Fail
                case CourseStatus.addingFail:
                  showErrorSnack(
                      context: context, data: "Course Uploading is failed!");
                  break;
                case CourseStatus.updatingFail:
                  showErrorSnack(
                      context: context, data: "Course Updating is failed!");
                  break;
                case CourseStatus.deletingFail:
                  showErrorSnack(
                      context: context, data: "Course Deleting is failed!");
                  break;
                default:
              }
            }),
        BlocListener<DiscountBloc, DiscountState>(
            listenWhen: (previous, current) =>
                previous.discountStatus != current.discountStatus,
            listener: (context, state) {
              switch (state.discountStatus) {
                //discount
                //lesson
                case DiscountStatus.addingSuccess:
                  showSuccessSnack(
                      context: context,
                      data: "Discount Uploading is successful!");
                  break;
                case DiscountStatus.addingFail:
                  showErrorSnack(
                      context: context, data: "Discount Uploading is failed!");
                  break;
                case DiscountStatus.updatingSuccess:
                  showSuccessSnack(
                      context: context,
                      data: "Discount updating is successful!");
                  break;
                case DiscountStatus.updatingFail:
                  showErrorSnack(
                      context: context, data: "Discount updating is failed!");
                  break;
                case DiscountStatus.deletingSuccess:
                  showSuccessSnack(
                      context: context,
                      data: "Discount deleting is successful!");
                  break;
                case DiscountStatus.deletingFail:
                  showErrorSnack(
                      context: context, data: "Discount deleting is failed!");
                  break;
                default:
              }
            }),
        //STUDENT
        BlocListener<StudentBloc, StudentState>(
            listenWhen: (previous, current) =>
                previous.studentStatus != current.studentStatus,
            listener: (context, state) {
              switch (state.studentStatus) {
                //Student
                //lesson
                case StudentStatus.addingSuccess:
                  showSuccessSnack(
                      context: context,
                      data: "Student Uploading is successful!");
                  break;
                case StudentStatus.addingFail:
                  showErrorSnack(
                      context: context, data: "Student Uploading is failed!");
                  break;
                case StudentStatus.deletingSuccess:
                  showSuccessSnack(
                      context: context,
                      data: "Student deleting is successful!");
                  break;
                case StudentStatus.deletingFail:
                  showErrorSnack(
                      context: context, data: "Student deleting is failed!");
                  break;
                default:
              }
            })
      ],
      child: BlocBuilder<AuthBloc, AuthState>(builder: (context, state) {
        if (state.authStatus == AuthStatus.authenticated) {
          return const HomePage();
        } else {
          return const SigninPage();
        }
      }),
    );
  }
}
