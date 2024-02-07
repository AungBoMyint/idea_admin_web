import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:mmlearning_admin/app_icon.dart';
import 'package:mmlearning_admin/app_image.dart';
import 'package:mmlearning_admin/bloc/core_bloc.dart';
import 'package:mmlearning_admin/constant.dart';
import 'package:mmlearning_admin/extension_widget.dart';
import 'package:mmlearning_admin/function.dart';
import 'package:mmlearning_admin/home/presentation/widget/loading_widget.dart';

import '../../../bloc/bloc/category_bloc.dart';

class CategoryAddPage extends StatelessWidget {
  const CategoryAddPage({super.key});

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
        child:
            BlocBuilder<CategoryBloc, CategoryState>(builder: (context, state) {
          return FloatingActionButton(
            backgroundColor: primaryColor,
            onPressed: () {
              if (state.selectedCategory == null) {
                context.read<CategoryBloc>().add(AddCategoryEvent());
              } else {
                context.read<CategoryBloc>().add(UpdateCategoryEvent());
              }
            },
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            child: state.formStatus == FormzSubmissionStatus.inProgress
                ? const LoadingWidget(
                    color: Colors.white,
                  )
                : Text(
                    state.selectedCategory == null ? "SAVE" : "UPDATE",
                    style: textTheme.bodySmall?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
          );
        }),
      ),
      body: Builder(builder: (context) {
        final status = context.select((CategoryBloc bloc) => bloc.state.status);
        return status == CategoryStatus.loading
            ? const LoadingWidget()
            : Card(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    20.v(),
                    //appbar
                    Row(
                      children: [
                        InkWell(
                          onTap: () {
                            context.read<CoreBloc>().add(ChangeDetailPageEvent(
                                detailPage: DetailPage.empty));
                            context
                                .read<CategoryBloc>()
                                .add(SetSelectedCategory(category: null));
                          },
                          child: Image.asset(
                            AppIcon.backArrow,
                            width: 30,
                            height: 30,
                          ),
                        ),
                        10.h(),
                        BlocBuilder<CategoryBloc, CategoryState>(
                            builder: (context, state) {
                          return Text(
                            state.selectedCategory == null
                                ? "Add Category"
                                : "Update Category",
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
                            (CategoryBloc bloc) => bloc.state.formImage);
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
                    10.v(),
                    Padding(
                      padding: const EdgeInsets.only(left: 40),
                      child: ElevatedButton(
                        onPressed: () {
                          pickImage().then((value) => context
                              .read<CategoryBloc>()
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
                      child: BlocBuilder<CategoryBloc, CategoryState>(
                          builder: (context, state) {
                        return TextFormField(
                          key: UniqueKey(),
                          autofocus: true,
                          initialValue: state.formTitle.value,
                          onChanged: (v) => context
                              .read<CategoryBloc>()
                              .add(TitleChangeEvent(title: v)),
                          decoration: InputDecoration(
                            border: border,
                            focusedBorder: border,
                            enabledBorder: border,
                            disabledBorder: border,
                            labelText: "Title",
                            floatingLabelStyle: textTheme.displayLarge,
                            errorText: state.formTitle.displayError == null
                                ? null
                                : "Title is required.",
                          ),
                        );
                      }),
                    ).withPadding(h: 40, v: 0),
                    //Button
                  ],
                ).withPadding(h: 10, v: 10),
              );
      }),
    ).withPaddingOnly(right: 20);
  }
}
