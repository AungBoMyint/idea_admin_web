import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:html_editor_enhanced/html_editor.dart';
import 'package:mmlearning_admin/app_icon.dart';
import 'package:mmlearning_admin/app_image.dart';
import 'package:mmlearning_admin/bloc/core_bloc.dart';
import 'package:mmlearning_admin/constant.dart';
import 'package:mmlearning_admin/extension_widget.dart';
import 'package:mmlearning_admin/mock.dart';

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
        child: FloatingActionButton(
          backgroundColor: primaryColor,
          onPressed: () {},
          child: Text(
            "SAVE",
            style: textTheme.bodySmall?.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
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
                    "Add Review",
                    style: textTheme.displayLarge,
                  ),
                ],
              ),
              20.v(),
              //Title
              SizedBox(
                width: size.width * 0.4,
                child: TextField(
                  autofocus: true,
                  decoration: InputDecoration(
                    border: border,
                    focusedBorder: border,
                    enabledBorder: border,
                    disabledBorder: border,
                    labelText: "Review",
                    floatingLabelStyle: textTheme.displayLarge,
                  ),
                ),
              ).withPadding(h: 40, v: 0),
              20.v(),
              Text("Choose Course", style: textTheme.displayLarge)
                  .withPaddingOnly(left: 40),
              10.v(),
              Wrap(
                children: courses
                    .map((e) => InkWell(
                          child: Container(
                            margin: EdgeInsets.symmetric(
                                horizontal: 5, vertical: 4),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.grey,
                                width: 2,
                              ),
                              borderRadius: BorderRadius.all(
                                Radius.circular(20),
                              ),
                            ),
                            padding: const EdgeInsets.only(
                                left: 20, right: 20, top: 10, bottom: 10),
                            child: Text(
                              e,
                              style: textTheme.displaySmall,
                            ),
                          ),
                        ))
                    .toList(),
              ).withPaddingOnly(left: 40, right: 20),
              20.v(),
              //choose student
              Text("Choose Student", style: textTheme.displayLarge)
                  .withPaddingOnly(left: 40),
              10.v(),
              Wrap(
                children: students
                    .map((e) => InkWell(
                          child: Container(
                            margin: EdgeInsets.symmetric(
                                horizontal: 5, vertical: 4),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.grey,
                                width: 2,
                              ),
                              borderRadius: BorderRadius.all(
                                Radius.circular(20),
                              ),
                            ),
                            padding: const EdgeInsets.only(
                                left: 20, right: 20, top: 10, bottom: 10),
                            child: Text(
                              e,
                              style: textTheme.displaySmall,
                            ),
                          ),
                        ))
                    .toList(),
              ).withPaddingOnly(left: 40, right: 20),
            ],
          ),
        ).withPadding(h: 10, v: 10),
      ),
    ).withPaddingOnly(right: 20) /* .withPadding(h: 20, v: 0) */;
  }
}
