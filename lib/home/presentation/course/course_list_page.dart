import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mmlearning_admin/bloc/bloc/course_bloc.dart';
import 'package:mmlearning_admin/bloc/core_bloc.dart';
import 'package:mmlearning_admin/constant.dart';
import 'package:mmlearning_admin/extension_widget.dart';
import 'package:mmlearning_admin/home/data/course_data_source.dart';
import 'package:mmlearning_admin/home/presentation/home_page.dart';
import 'package:mmlearning_admin/mock.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../../../app_icon.dart';
import '../../../core/presentation/responsive_builder.dart';
import '../../../enum_class.dart';
import '../../../function.dart';
import '../widget/drawer_mobile.dart';
import '../widget/error_widget.dart';
import '../widget/loading_widget.dart';

class CourseListPage extends StatelessWidget {
  const CourseListPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    const border = OutlineInputBorder(
      borderSide: BorderSide(
        color: Colors.black,
      ),
    );
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
            child: Column(
              children: [
                //Search & Add
                Card(
                  child: SizedBox(
                    height: 40,
                    width:
                        status == SizeStatus.desktop ? size.width * 0.8 : null,
                    child: Row(
                      children: [
                        status == SizeStatus.desktop
                            ? SizedBox(
                                width: size.width * 0.3,
                                child: TextFormField(
                                  onFieldSubmitted: (v) => context
                                      .read<CourseBloc>()
                                      .add(SearchCourse(value: v)),
                                  decoration: InputDecoration(
                                    contentPadding: EdgeInsets.only(right: 20),
                                    prefixIcon: Icon(Icons.search),
                                    hintText: "Search",
                                    border: border,
                                    enabledBorder: border,
                                    focusedBorder: border,
                                    disabledBorder: border,
                                  ),
                                ),
                              )
                            : Expanded(
                                child: TextFormField(
                                  onFieldSubmitted: (v) => context
                                      .read<CourseBloc>()
                                      .add(SearchCourse(value: v)),
                                  decoration: InputDecoration(
                                    contentPadding: EdgeInsets.only(right: 20),
                                    prefixIcon: Icon(Icons.search),
                                    hintText: "Search",
                                    border: border,
                                    enabledBorder: border,
                                    focusedBorder: border,
                                    disabledBorder: border,
                                  ),
                                ),
                              ),
                        status == SizeStatus.desktop
                            ? Expanded(child: const SizedBox())
                            : 20.h(),
                        ElevatedButton(
                          onPressed: () {
                            context
                                .read<CourseBloc>()
                                .add(ChangeSelectedCourse(course: null));
                            context.read<CoreBloc>().add(ChangeDetailPageEvent(
                                detailPage: DetailPage.courseAdd));
                          },
                          child: Icon(
                            Icons.add,
                            color: Colors.white,
                          ),
                        ).withDefault(
                          height: 40,
                          radius: 10,
                        ),
                        10.h(),
                        status == SizeStatus.desktop
                            ? GestureDetector(
                                onTapDown: (details) => showProfilePopupMenu(
                                    context, details.globalPosition),
                                child: CircleAvatar(
                                  backgroundColor: primaryColor,
                                  radius: 20,
                                  child: CircleAvatar(
                                    radius: 18,
                                    backgroundColor: Colors.white,
                                    child: Image.asset(
                                      AppIcon.profile,
                                      height: 30,
                                      width: 30,
                                    ),
                                  ),
                                ))
                            : const SizedBox(),
                      ],
                    ),
                  ).withPadding(h: 10, v: 20),
                ),
                20.v(),
                Expanded(
                  child: LayoutBuilder(builder: (context, constraints) {
                    final avWidth = constraints.maxWidth;
                    final width = avWidth / 6;
                    return BlocBuilder<CourseBloc, CourseState>(
                        builder: (context, state) {
                      if (state.status == RequestStatus.fetching) {
                        return const LoadingWidget();
                      }
                      if (state.status == RequestStatus.error) {
                        return CustomErrorWidget(errorText: state.error ?? "");
                      }

                      return state.courses?.isEmpty == true
                          ? const SizedBox()
                          : Card(
                              child: SfDataGrid(
                                source: CourseDataSource(
                                    courses: state.courses ?? []),
                                loadMoreViewBuilder: (BuildContext context,
                                    LoadMoreRows loadMoreRows) {
                                  Future<String> loadRows() async {
                                    // Call the loadMoreRows function to call the
                                    // DataGridSource.handleLoadMoreRows method. So, additional
                                    // rows can be added from handleLoadMoreRows method.
                                    await loadMoreRows();
                                    return Future<String>.value('Completed');
                                  }

                                  return FutureBuilder<String>(
                                      initialData: 'loading',
                                      future: loadRows(),
                                      builder: (context, snapShot) {
                                        if (snapShot.data == 'loading') {
                                          return Container(
                                              height: 60.0,
                                              width: double.infinity,
                                              decoration: const BoxDecoration(
                                                  color: Colors.white,
                                                  border: BorderDirectional(
                                                      top: BorderSide(
                                                          width: 1.0,
                                                          color: Color.fromRGBO(
                                                              0, 0, 0, 0.26)))),
                                              alignment: Alignment.center,
                                              child: CircularProgressIndicator(
                                                color: primaryColor,
                                              ));
                                        } else {
                                          return SizedBox.fromSize(
                                              size: Size.zero);
                                        }
                                      });
                                },
                                columns: <GridColumn>[
                                  GridColumn(
                                      columnName: 'actions',
                                      width: 100,
                                      label: Container(
                                          padding: EdgeInsets.all(16.0),
                                          child: Text(
                                            'ACTIONS',
                                          ))),
                                  GridColumn(
                                      columnName: 'title',
                                      width: width + 100,
                                      label: Container(
                                          padding: EdgeInsets.all(16.0),
                                          alignment: Alignment.center,
                                          child: Text(
                                            'TITLE',
                                          ))),
                                  GridColumn(
                                      columnName: 'price',
                                      width: width + 100,
                                      label: Container(
                                          alignment: Alignment.center,
                                          padding: EdgeInsets.all(16.0),
                                          child: Text('PRICE'))),
                                  GridColumn(
                                      columnName: 'students',
                                      width: width,
                                      label: Container(
                                          alignment: Alignment.center,
                                          padding: EdgeInsets.all(16.0),
                                          child: Text('STUDENTS'))),
                                  GridColumn(
                                      columnName: 'ratings',
                                      width: width,
                                      label: Container(
                                          alignment: Alignment.center,
                                          padding: EdgeInsets.all(16.0),
                                          child: Text('RATINGS'))),
                                  GridColumn(
                                      columnName: 'reviews',
                                      width: width,
                                      label: Container(
                                          alignment: Alignment.center,
                                          padding: EdgeInsets.all(16.0),
                                          child: Text('REVIEWS'))),
                                ],
                              ),
                            );
                    });
                  }),
                ),
              ],
            ),
          ),
        ],
      );
    }).withPaddingOnly(right: 20);
  }
}
