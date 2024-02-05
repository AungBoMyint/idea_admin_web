import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mmlearning_admin/app_icon.dart';
import 'package:mmlearning_admin/app_image.dart';
import 'package:mmlearning_admin/bloc/bloc/student_bloc.dart';
import 'package:mmlearning_admin/bloc/core_bloc.dart';
import 'package:mmlearning_admin/constant.dart';
import 'package:mmlearning_admin/extension_widget.dart';
import 'package:mmlearning_admin/home/presentation/widget/loading_widget.dart';

import '../../../function.dart';

class StudentAddPage extends StatelessWidget {
  const StudentAddPage({super.key});

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
              context.select((StudentBloc bloc) => bloc.state.studentStatus);
          return FloatingActionButton(
            backgroundColor: primaryColor,
            onPressed: () {
              context.read<StudentBloc>().add(AddStudent());
            },
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            child: status == StudentStatus.adding
                ? const LoadingWidget(
                    color: Colors.white,
                  )
                : Text(
                    "SAVE",
                    style: textTheme.bodySmall?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
          );
        }),
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
                    "Add Student",
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
                  final image = context
                      .select((StudentBloc bloc) => bloc.state.formAvatar);
                  return image.value.isNotEmpty
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
                    (value) => context.read<StudentBloc>().add(
                          ChangeAvatar(value: value),
                        ),
                  ),
                  child: Text(
                    "Choose Avatar",
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
                child: TextFormField(
                  autofocus: true,
                  onChanged: (v) =>
                      context.read<StudentBloc>().add(ChangeUserName(value: v)),
                  decoration: InputDecoration(
                    border: border,
                    focusedBorder: border,
                    enabledBorder: border,
                    disabledBorder: border,
                    labelText: "Username",
                    floatingLabelStyle: textTheme.displayLarge,
                  ),
                ),
              ).withPadding(h: 40, v: 0),
              20.v(),
              //Email
              SizedBox(
                width: size.width * 0.4,
                child: TextField(
                  autofocus: true,
                  onChanged: (v) =>
                      context.read<StudentBloc>().add(ChangeEmail(value: v)),
                  decoration: InputDecoration(
                    border: border,
                    focusedBorder: border,
                    enabledBorder: border,
                    disabledBorder: border,
                    labelText: "Email",
                    floatingLabelStyle: textTheme.displayLarge,
                  ),
                ),
              ).withPadding(h: 40, v: 0),
              20.v(),
              //passwrod
              SizedBox(
                width: size.width * 0.4,
                child: TextField(
                  autofocus: true,
                  onChanged: (v) =>
                      context.read<StudentBloc>().add(ChangePassword(value: v)),
                  decoration: InputDecoration(
                    border: border,
                    focusedBorder: border,
                    enabledBorder: border,
                    disabledBorder: border,
                    labelText: "Password",
                    floatingLabelStyle: textTheme.displayLarge,
                  ),
                ),
              ).withPadding(h: 40, v: 0),
              20.v(),
              //FirstName
              SizedBox(
                width: size.width * 0.4,
                child: TextField(
                  autofocus: true,
                  onChanged: (v) => context
                      .read<StudentBloc>()
                      .add(ChangeFirstName(value: v)),
                  decoration: InputDecoration(
                    border: border,
                    focusedBorder: border,
                    enabledBorder: border,
                    disabledBorder: border,
                    labelText: "First name",
                    floatingLabelStyle: textTheme.displayLarge,
                  ),
                ),
              ).withPadding(h: 40, v: 0),
              20.v(),
              //last name
              SizedBox(
                width: size.width * 0.4,
                child: TextField(
                  autofocus: true,
                  onChanged: (v) =>
                      context.read<StudentBloc>().add(ChangeLastName(value: v)),
                  decoration: InputDecoration(
                    border: border,
                    focusedBorder: border,
                    enabledBorder: border,
                    disabledBorder: border,
                    labelText: "Last name",
                    floatingLabelStyle: textTheme.displayLarge,
                  ),
                ),
              ).withPadding(h: 40, v: 0),
            ],
          ).withPadding(h: 10, v: 10),
        ),
      ).withPaddingOnly(right: 20),
    );
  }
}
