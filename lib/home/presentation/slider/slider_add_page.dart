import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:html_editor_enhanced/html_editor.dart';
import 'package:mmlearning_admin/app_icon.dart';
import 'package:mmlearning_admin/app_image.dart';
import 'package:mmlearning_admin/bloc/bloc/course_bloc.dart';
import 'package:mmlearning_admin/bloc/bloc/slider_bloc.dart';
import 'package:mmlearning_admin/bloc/core_bloc.dart';
import 'package:mmlearning_admin/constant.dart';
import 'package:mmlearning_admin/extension_widget.dart';
import 'package:mmlearning_admin/home/presentation/widget/loading_widget.dart';
import 'package:mmlearning_admin/mock.dart';

import '../../../function.dart';

class SliderAddPage extends StatelessWidget {
  const SliderAddPage({super.key});

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
          final status =
              context.select((SliderBloc bloc) => bloc.state.sliderStatus);
          final selectedSlider =
              context.select((SliderBloc bloc) => bloc.state.selectedSlider);
          return FloatingActionButton(
            backgroundColor: primaryColor,
            onPressed: () {
              if (selectedSlider == null) {
                //mean upload
                context.read<SliderBloc>().add(AddSliderEvent());
              } else {
                //mean update
                context.read<SliderBloc>().add(UpdateSliderEvent());
              }
            },
            child:
                status == SliderStatus.adding || status == SliderStatus.updating
                    ? const LoadingWidget(
                        color: Colors.white,
                      )
                    : Text(
                        selectedSlider == null ? "SAVE" : "UPDATE",
                        style: textTheme.bodySmall?.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
          );
        }),
      ),
      body: Card(
        child: SingleChildScrollView(
          child: Builder(builder: (context) {
            final status =
                context.select((SliderBloc bloc) => bloc.state.sliderStatus);
            return status == SliderStatus.loading
                ? const LoadingWidget()
                : Column(
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
                          Builder(builder: (context) {
                            final selectedSlider = context.select(
                                (SliderBloc bloc) => bloc.state.selectedSlider);
                            return Text(
                              selectedSlider == null
                                  ? "Add Slider"
                                  : "Update Slider",
                              style: textTheme.displayLarge,
                            );
                          }),
                        ],
                      ),
                      20.v(),
                      //Image
                      Builder(
                        builder: (context) {
                          final formImage = context.select(
                              (SliderBloc bloc) => bloc.state.formImage);
                          return Container(
                            width: 180,
                            color: Colors.white,
                            padding: const EdgeInsets.all(10),
                            child: formImage.value.isNotEmpty
                                ? Image.memory(
                                    Uint8List.fromList(formImage.value),
                                    height: 80,
                                    width: 80,
                                  )
                                : Image.asset(
                                    AppIcon.gallery,
                                    height: 80,
                                    width: 80,
                                  ),
                          );
                        },
                      ).withPadding(h: 40, v: 0),
                      20.v(),
                      Padding(
                        padding: const EdgeInsets.only(left: 40),
                        child: ElevatedButton(
                          onPressed: () {
                            pickImage().then((value) => context
                                .read<SliderBloc>()
                                .add(ImageChangeEvent(image: value)));
                          },
                          child: Text(
                            "Choose Image",
                            style: theme.textTheme.displayMedium?.copyWith(
                              color: Colors.white,
                            ),
                          ),
                        ).withDefault(
                          radius: 10,
                          height: 35,
                          width: 180,
                        ),
                      ),
                      20.v(),
                      //Title
                      SizedBox(
                        width: size.width * 0.4,
                        child: Builder(builder: (context) {
                          final formTitle = context.select(
                              (SliderBloc bloc) => bloc.state.formTitle);
                          return TextFormField(
                            autofocus: true,
                            initialValue: formTitle.value,
                            onChanged: (v) => context
                                .read<SliderBloc>()
                                .add(TitleChangeEvent(title: v)),
                            decoration: InputDecoration(
                              border: border,
                              focusedBorder: border,
                              enabledBorder: border,
                              disabledBorder: border,
                              labelText: "Title",
                              floatingLabelStyle: textTheme.displayLarge,
                            ),
                          );
                        }),
                      ).withPadding(h: 40, v: 0),
                      20.v(),
                      //MessengerLink
                      SizedBox(
                        width: size.width * 0.4,
                        child: Builder(builder: (context) {
                          final formMessenger = context.select(
                              (SliderBloc bloc) => bloc.state.formMessenger);
                          return TextFormField(
                            autofocus: true,
                            initialValue: formMessenger?.value,
                            onChanged: (v) => context
                                .read<SliderBloc>()
                                .add(MessengerChangeEvent(value: v)),
                            decoration: InputDecoration(
                              border: border,
                              focusedBorder: border,
                              enabledBorder: border,
                              disabledBorder: border,
                              labelText: "MessengerLink(Optional)",
                              floatingLabelStyle: textTheme.displayLarge,
                            ),
                          );
                        }),
                      ).withPadding(h: 40, v: 0),
                      20.v(),
                      //FacebookLink
                      SizedBox(
                        width: size.width * 0.4,
                        child: Builder(builder: (context) {
                          final formFacebook = context.select(
                              (SliderBloc bloc) => bloc.state.formFacebook);
                          return TextFormField(
                            autofocus: true,
                            initialValue: formFacebook?.value,
                            onChanged: (v) => context
                                .read<SliderBloc>()
                                .add(FacebookChangeEvent(value: v)),
                            decoration: InputDecoration(
                              border: border,
                              focusedBorder: border,
                              enabledBorder: border,
                              disabledBorder: border,
                              labelText: "FacebookLink(Optional)",
                              floatingLabelStyle: textTheme.displayLarge,
                            ),
                          );
                        }),
                      ).withPadding(h: 40, v: 0),
                      20.v(),
                      //YoutubeLink
                      SizedBox(
                        width: size.width * 0.4,
                        child: Builder(builder: (context) {
                          final formYoutube = context.select(
                              (SliderBloc bloc) => bloc.state.formYoutube);
                          return TextFormField(
                            autofocus: true,
                            initialValue: formYoutube?.value,
                            onChanged: (v) => context
                                .read<SliderBloc>()
                                .add(YoutubeChangeEvent(value: v)),
                            decoration: InputDecoration(
                              border: border,
                              focusedBorder: border,
                              enabledBorder: border,
                              disabledBorder: border,
                              labelText: "YoutubeLink(Optional)",
                              floatingLabelStyle: textTheme.displayLarge,
                            ),
                          );
                        }),
                      ).withPadding(h: 40, v: 0),
                      20.v(),
                      /*  //Blog
                  Text("Blog(Optional)", style: textTheme.displayLarge)
                      .withPaddingOnly(left: 40),
                  10.v(),
                  Container(
                    decoration: BoxDecoration(
                        border: Border.all(
                      color: primaryColor,
                      width: 3,
                    )),
                    child: HtmlEditor(
                      htmlToolbarOptions: const HtmlToolbarOptions(
                        toolbarPosition: ToolbarPosition.aboveEditor, //by default
                        toolbarType: ToolbarType.nativeGrid,
                      ),
                      controller: HtmlEditorController(), //required
                      htmlEditorOptions: const HtmlEditorOptions(
                        hint: "Your text here...",
                        //initalText: "text content initial, if any",
                      ),
                      otherOptions: OtherOptions(
                        height: 400,
                      ),
                    ),
                  ).withPaddingOnly(left: 40, right: 20),
                  20.v(), */
                      Text("Choose Courses(Optional)",
                              style: textTheme.displayLarge)
                          .withPaddingOnly(left: 40),
                      10.v(),
                      Builder(
                        builder: (context) {
                          final formCourses = context.select(
                              (SliderBloc bloc) => bloc.state.formCourse);
                          final courses = context
                              .select((CourseBloc bloc) => bloc.state.courses);
                          return Wrap(
                            children: (courses ?? [])
                                .map((e) => InkWell(
                                      onTap: () => context
                                          .read<SliderBloc>()
                                          .add(CourseLinkChangeEvent(id: e.id)),
                                      child: Container(
                                        margin: const EdgeInsets.symmetric(
                                            horizontal: 5, vertical: 4),
                                        decoration: BoxDecoration(
                                          color: formCourses?.value
                                                      .contains(e.id) ==
                                                  true
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
                                          style:
                                              textTheme.displaySmall?.copyWith(
                                            color: formCourses?.value
                                                        .contains(e.id) ==
                                                    true
                                                ? Colors.white
                                                : null,
                                          ),
                                        ),
                                      ),
                                    ))
                                .toList(),
                          );
                        },
                      ).withPaddingOnly(left: 40, right: 20),
                    ],
                  );
          }),
        ).withPadding(h: 10, v: 10),
      ),
    ).withPaddingOnly(right: 20) /* .withPadding(h: 20, v: 0) */;
  }
}
