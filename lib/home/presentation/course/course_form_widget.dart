import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mmlearning_admin/extension_widget.dart';

import '../../../app_icon.dart';
import '../../../bloc/bloc/category_bloc.dart';
import '../../../bloc/bloc/course_bloc.dart';
import '../../../constant.dart';
import '../../../function.dart';

class CourseFormWidget extends StatelessWidget {
  const CourseFormWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        //Image
        Row(
          children: [
            //File
            Column(
              children: [
                Container(
                  width: 180,
                  height: 100,
                  color: Colors.white,
                  padding: const EdgeInsets.all(10),
                  child: Builder(builder: (context) {
                    final course = context
                        .select((CourseBloc bloc) => bloc.state.selectedCourse);
                    final image =
                        context.select((CourseBloc bloc) => bloc.state.image);
                    return image.value.length == 1
                        ? Image.network(
                            course?.image ?? "",
                            height: 80,
                            width: 80,
                          )
                        : image.value.isNotEmpty
                            ? Image.memory(
                                Uint8List.fromList(image.value),
                              )
                            : Image.asset(
                                AppIcon.gallery,
                                height: 80,
                                width: 80,
                              );
                  }),
                ).withPadding(h: 40, v: 0),
                20.v(),
                /*   Padding(
                padding: const EdgeInsets.only(left: 20),
                child:  */
                ElevatedButton(
                  onPressed: () => pickImage().then(
                    (value) => context.read<CourseBloc>().add(
                          ChangeImageEvent(image: value),
                        ),
                  ),
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
                /* ), */
                20.v(),
                //Video
                Builder(
                  builder: (context) {
                    final video =
                        context.select((CourseBloc bloc) => bloc.state.video);

                    return Container(
                      width: 180,
                      color: Colors.white,
                      padding: const EdgeInsets.all(10),
                      child: video.value.isNotEmpty
                          ? Text(video.value["name"])
                          : Image.asset(
                              AppIcon.video,
                              height: 80,
                              width: 80,
                            ),
                    );
                  },
                ).withPadding(h: 40, v: 0),
                20.v(),

                ElevatedButton(
                  onPressed: () => pickVideo().then((value) {
                    if (!(value == null)) {
                      context
                          .read<CourseBloc>()
                          .add(ChangeVideoEvent(data: value));
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
            //TextForm
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //Title
                SizedBox(
                  width: size.width * 0.4,
                  child: Builder(builder: (context) {
                    final title =
                        context.select((CourseBloc bloc) => bloc.state.title);
                    return TextFormField(
                      autofocus: true,
                      initialValue: title.value,
                      onChanged: (v) => context
                          .read<CourseBloc>()
                          .add(ChangeTitleEvent(value: v)),
                      decoration: InputDecoration(
                        border: border,
                        focusedBorder: border,
                        enabledBorder: border,
                        disabledBorder: border,
                        labelText: "Title",
                        errorText: title.displayError == null
                            ? null
                            : "Title is required",
                        floatingLabelStyle: textTheme.displayLarge,
                      ),
                    );
                  }),
                ).withPadding(h: 40, v: 0),
                20.v(),
                //Desc
                SizedBox(
                  width: size.width * 0.4,
                  child: Builder(builder: (context) {
                    final desc = context
                        .select((CourseBloc bloc) => bloc.state.description);
                    return TextFormField(
                      initialValue: desc.value,
                      autofocus: true,
                      maxLines: 5,
                      onChanged: (v) => context
                          .read<CourseBloc>()
                          .add(ChangeDescriptionEvent(value: v)),
                      decoration: InputDecoration(
                        border: border,
                        focusedBorder: border,
                        enabledBorder: border,
                        disabledBorder: border,
                        labelText: "Descriptioin",
                        errorText: desc.displayError == null
                            ? null
                            : "Description is required",
                        floatingLabelStyle: textTheme.displayLarge,
                      ),
                    );
                  }),
                ).withPadding(h: 40, v: 0),
                20.v(),
                //Price
                SizedBox(
                  width: size.width * 0.4,
                  child: Builder(builder: (context) {
                    final price =
                        context.select((CourseBloc bloc) => bloc.state.price);
                    return TextFormField(
                      autofocus: true,
                      initialValue: price.value.toString(),
                      onChanged: (v) => context
                          .read<CourseBloc>()
                          .add(ChangePriceEvent(value: int.tryParse(v) ?? 0)),
                      decoration: InputDecoration(
                        border: border,
                        focusedBorder: border,
                        enabledBorder: border,
                        disabledBorder: border,
                        labelText: "Price",
                        errorText: price.displayError == null
                            ? null
                            : "Price is required",
                        floatingLabelStyle: textTheme.displayLarge,
                      ),
                    );
                  }),
                ).withPadding(h: 40, v: 0),
                20.v(),
                //Featured
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Featured:",
                      style: textTheme.displayLarge,
                    ),
                    10.h(),
                    Builder(builder: (context) {
                      final featured = context
                          .select((CourseBloc bloc) => bloc.state.featured);
                      return Switch(
                        activeColor: primaryColor,
                        value: featured.value,
                        onChanged: (v) {
                          context
                              .read<CourseBloc>()
                              .add(ChangeFeatureEvent(value: v));
                        },
                      );
                    })
                  ],
                ).withPadding(h: 40, v: 0),
              ],
            ),
          ],
        ),
        20.v(),
        Text("Choose Category:", style: textTheme.displayLarge)
            .withPaddingOnly(left: 40),
        10.v(),
        Builder(builder: (context) {
          final category =
              context.select((CourseBloc bloc) => bloc.state.category);
          return Wrap(
            children: (context.read<CategoryBloc>().state.categories ?? [])
                .map((e) => InkWell(
                      onTap: () => context
                          .read<CourseBloc>()
                          .add(ChangeCategoryEvent(value: e.id)),
                      child: Container(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 5, vertical: 4),
                        decoration: BoxDecoration(
                          color: category.value == e.id
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
                            color: category.value == e.id ? Colors.white : null,
                          ),
                        ),
                      ),
                    ))
                .toList(),
          ).withPaddingOnly(left: 40, right: 20);
        }),
      ],
    );
  }
}
