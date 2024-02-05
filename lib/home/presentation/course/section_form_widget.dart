import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mmlearning_admin/extension_widget.dart';
import 'package:mmlearning_admin/home/presentation/widget/loading_widget.dart';
import '../../../bloc/bloc/course_bloc.dart';
import '../../../constant.dart';

class SectionFormWidget extends StatelessWidget {
  const SectionFormWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    return BlocBuilder<CourseBloc, CourseState>(
      builder: (context, state) {
        if (state.isSectionAdd == false) {
          return 0.h();
        }
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //
            Row(
              children: [
                SizedBox(
                  width: size.width * 0.4,
                  child: Builder(builder: (context) {
                    final selectedSection = context.select(
                        (CourseBloc bloc) => bloc.state.selectedSection);
                    return TextFormField(
                      initialValue: selectedSection?.title ?? "",
                      onChanged: (v) => context
                          .read<CourseBloc>()
                          .add(ChangeSectionTitleEvent(value: v)),
                      decoration: InputDecoration(
                        border: border,
                        focusedBorder: border,
                        enabledBorder: border,
                        disabledBorder: border,
                        labelText: "Section title",
                        floatingLabelStyle: textTheme.displayLarge,
                      ),
                    );
                  }),
                ),
                IconButton(
                    onPressed: () =>
                        context.read<CourseBloc>().add(ChangeSectionAdd()),
                    icon: const Icon(
                      Icons.remove,
                      color: Colors.red,
                    ))
              ],
            ),
            10.v(),
            //
            Builder(
              builder: (context) {
                final selectedSection = context
                    .select((CourseBloc bloc) => bloc.state.selectedSection);
                final courseStatus = context
                    .select((CourseBloc bloc) => bloc.state.courseStatus);
                return ElevatedButton(
                  onPressed: () {
                    if (selectedSection == null) {
                      context.read<CourseBloc>().add(PostSectionEvent());
                    } else {
                      //update
                      context.read<CourseBloc>().add(UpdateSection());
                    }
                  },
                  child: courseStatus == CourseStatus.addingSection ||
                          courseStatus == CourseStatus.updatingSection
                      ? const LoadingWidget(
                          color: Colors.white,
                        )
                      : Text(
                          selectedSection == null ? "Add" : "Update",
                          style: theme.textTheme.displayMedium?.copyWith(
                            color: Colors.white,
                          ),
                        ),
                ).withDefault(
                  radius: 10,
                  height: 35,
                  width: size.width * 0.4,
                );
              },
            )
          ],
        );
      },
    );
  }
}
