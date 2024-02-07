import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mmlearning_admin/app_icon.dart';
import 'package:mmlearning_admin/app_image.dart';
import 'package:mmlearning_admin/bloc/bloc/course_bloc.dart';
import 'package:mmlearning_admin/bloc/bloc/discount_bloc.dart';
import 'package:mmlearning_admin/bloc/core_bloc.dart';
import 'package:mmlearning_admin/constant.dart';
import 'package:mmlearning_admin/extension_widget.dart';
import 'package:mmlearning_admin/home/presentation/widget/loading_widget.dart';

import '../../../function.dart';
import '../../../mock.dart';

class DiscountAddPage extends StatelessWidget {
  const DiscountAddPage({super.key});

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
              context.select((DiscountBloc bloc) => bloc.state.discountStatus);
          final selectedDiscount = context
              .select((DiscountBloc bloc) => bloc.state.selectedDiscount);
          return FloatingActionButton(
            backgroundColor: primaryColor,
            onPressed: () {
              if (selectedDiscount == null) {
                //add
                context.read<DiscountBloc>().add(AddDiscount());
              } else {
                //update
                context.read<DiscountBloc>().add(UpdateDiscount());
              }
            },
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            child: status == DiscountStatus.adding ||
                    status == DiscountStatus.updating
                ? const LoadingWidget(
                    color: Colors.white,
                  )
                : Text(
                    selectedDiscount == null ? "SAVE" : "UPDATE",
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
            context.select((DiscountBloc bloc) => bloc.state.discountStatus);
        return status == DiscountStatus.loading
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
                            "Add Discount",
                            style: textTheme.displayLarge,
                          ),
                        ],
                      ),
                      20.v(),
                      //Image
                      Container(
                        width: 180,
                        color: Colors.white,
                        padding: const EdgeInsets.all(10),
                        child: Builder(builder: (context) {
                          final course = context.select((DiscountBloc bloc) =>
                              bloc.state.selectedDiscount);
                          final image = context.select(
                              (DiscountBloc bloc) => bloc.state.formImage);
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
                      10.v(),
                      Padding(
                        padding: const EdgeInsets.only(left: 40),
                        child: ElevatedButton(
                          onPressed: () => pickImage().then(
                            (value) => context.read<DiscountBloc>().add(
                                  ChangeImage(value: value),
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
                      ),
                      20.v(),
                      //Title
                      SizedBox(
                        width: size.width * 0.4,
                        child: Builder(builder: (context) {
                          final title = context.select(
                              (DiscountBloc bloc) => bloc.state.formTitle);
                          return TextFormField(
                            autofocus: true,
                            initialValue: title.value,
                            onChanged: (v) => context
                                .read<DiscountBloc>()
                                .add(ChangeTitle(value: v)),
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
                      SizedBox(
                        width: size.width * 0.4,
                        child: Builder(builder: (context) {
                          final percent = context.select(
                              (DiscountBloc bloc) => bloc.state.formPercentage);
                          return TextFormField(
                            autofocus: true,
                            initialValue: percent.value.toString(),
                            onChanged: (v) => context.read<DiscountBloc>().add(
                                ChangeDiscount(value: double.tryParse(v) ?? 0)),
                            decoration: InputDecoration(
                              border: border,
                              focusedBorder: border,
                              enabledBorder: border,
                              disabledBorder: border,
                              labelText: "Discount Percentage",
                              floatingLabelStyle: textTheme.displayLarge,
                            ),
                          );
                        }),
                      ).withPadding(h: 40, v: 0),
                      //Discount Item
                      20.v(),
                      Text("Choose Discount Courses(Optional)",
                              style: textTheme.displayLarge)
                          .withPaddingOnly(left: 40),
                      10.v(),
                      Builder(
                        builder: (context) {
                          final courses = context
                              .select((CourseBloc bloc) => bloc.state.courses);
                          final idList = context.select((DiscountBloc bloc) =>
                              bloc.state.formDiscountItems);
                          return Wrap(
                            children: (courses ?? [])
                                .map((e) => InkWell(
                                      onTap: () => context
                                          .read<DiscountBloc>()
                                          .add(ChangeDiscountItem(id: e.id)),
                                      child: Container(
                                        margin: const EdgeInsets.symmetric(
                                            horizontal: 5, vertical: 4),
                                        decoration: BoxDecoration(
                                          color: idList.value.contains(e.id)
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
                                            color: idList.value.contains(e.id)
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
                  ).withPadding(h: 10, v: 10),
                ),
              );
      }),
    ).withPaddingOnly(right: 20) /* .withPadding(h: 20, v: 0) */;
  }
}
